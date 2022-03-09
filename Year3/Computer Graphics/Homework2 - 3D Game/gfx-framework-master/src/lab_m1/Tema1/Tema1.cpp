#include "lab_m1/Tema1/Tema1.h"

#include <vector>
#include <iostream>

#include "lab_m1/Tema1/transform2D.h"
#include "lab_m1/Tema1/object2D.h"

#include <math.h>
#include <time.h> 
#define PI 3.14159265


using namespace std;
using namespace m1;

clock_t lastAmmo, timeAmmo;
clock_t lastSpawn, now;


glm::vec2 Vec3toVec2(glm::vec3 vec3) {
    return glm::vec2(vec3.x, vec3.y);
}

float clamp(float value, float min, float max) {
    return std::max(min, std::min(max, value));
}



bool CheckColision(m1::Tema1::GameObjectCircle circle, m1::Tema1::GameObjectRectangle obstacle) {

    //centerOfObstacle and centerOfCircle
    glm::vec2 centerOfObstacle = glm::vec2(obstacle.x, obstacle.y);
    glm::vec2 centerOfCircle = glm::vec2(circle.x, circle.y);

    //get half-extents
    glm::vec2 obstacleHalfExtents = glm::vec2(obstacle.width / 2.0f, obstacle.height / 2.0f);

    //get difference vector between both ceneters
    glm::vec2 difference = centerOfCircle - centerOfObstacle;
    glm::vec2 clamped = glm::clamp(difference, -obstacleHalfExtents, obstacleHalfExtents);

    //determine closest point to the circle
    glm::vec2 closest = centerOfObstacle + clamped;

    //determine the distance btw the center of the circle
    // and the closest poin
    difference = closest - centerOfCircle;

    return glm::length(difference) < circle.radius;
}

bool CheckCollisionWithAllObstacles(m1::Tema1::GameObjectCircle circle, vector<m1::Tema1::GameObjectRectangle> obstacles) {
    for (int i = 0; i < obstacles.size(); i++)
        if (CheckColision(circle, obstacles[i]))
            return true;
    return false;
}

vector<m1::Tema1::GameObjectRectangle> moveObstacles(vector<m1::Tema1::GameObjectRectangle> obstacles, float addX, float addY) {
    for (int i = 0; i < obstacles.size(); i++)
        obstacles[i].modifyPos(obstacles[i].x + addX, obstacles[i].y + addY);

    return obstacles;
}

bool CheckColisionAmmoObstacles(m1::Tema1::GameObjectRectangle ammo, vector<m1::Tema1::GameObjectRectangle> obstacles) {
    for (int i = 0; i < obstacles.size(); i++) {
        glm::vec2 bottomLeft = glm::vec2(obstacles[i].x - obstacles[i].width / 2 - ammo.width, obstacles[i].y - obstacles[i].height / 2 - ammo.width);
        glm::vec2 upperRight = glm::vec2(obstacles[i].x + obstacles[i].width / 2 + ammo.width, obstacles[i].y + obstacles[i].height / 2 + ammo.width);
        if (ammo.x >= bottomLeft.x && ammo.x <= upperRight.x && ammo.y >= bottomLeft.y && ammo.y <= upperRight.y)
            return true;
    }
    return false;
}

bool CheckColisionCharacterEnemy(m1::Tema1::GameObjectCircle character, m1::Tema1::GameObjectCircle enemy) {
    glm::vec2 centerChar = glm::vec2(character.x, character.y);
    glm::vec2 centerEnemy = glm::vec2(enemy.x, enemy.y);
    if (glm::length(centerChar - centerEnemy) < (character.radius + enemy.radius))
        return true;
    else
        return false;
}

vector<m1::Tema1::Enemy> moveEnemyes(vector<m1::Tema1::Enemy> enemies, float addX, float addY) {
    for (int i = 0; i < enemies.size(); i++)
        enemies[i].body.modifyPos(enemies[i].body.x + addX, enemies[i].body.y + addY);

    return enemies;
}


int random(int min, int max) {
    return min + rand() / (RAND_MAX / (max - min + 1) + 1);
}

/*
* functie care determina un x pe langa marginea exterioara a mapei
*/
int randomXOutOfMap(m1::Tema1::GameObjectRectangle terrain) {
    int choose = random(1, 2);


    int x1 = random(terrain.x - terrain.width / 2 + 110, terrain.x - terrain.width / 2 + 160);
    int x2 = random(terrain.x + terrain.width / 2 - 160, terrain.x + terrain.width / 2 - 110);

    if (choose == 2)
        return x2;
    else
        return x1;
}

/*
* functie care determina un y in interiorul mapei
*/
int randomY(m1::Tema1::GameObjectRectangle terrain) {
    int y = random(terrain.y - terrain.width / 2 + 110, terrain.y + terrain.width / 2 - 110);
    return y;
}

/*
* functie care determina un y pe langa marginea exterioara a mapei
*/
int randomYOutOfMap(m1::Tema1::GameObjectRectangle terrain) {
    int choose = random(1, 2);


    int y1 = random(terrain.y - terrain.width / 2 + 110, terrain.y - terrain.width / 2 + 160);
    int y2 = random(terrain.y + terrain.width / 2 - 160, terrain.y + terrain.width / 2 - 110);

    if (choose == 2)
        return y2;
    else
        return y1;
}

/*
* functie care determina un x in mapa
*/
int randomX(m1::Tema1::GameObjectRectangle terrain) {
    int x1 = random(terrain.x - terrain.width / 2 + 110, terrain.x - terrain.width - 110);
    return x1;

}


Tema1::Tema1()
{
}


Tema1::~Tema1()
{
}



void Tema1::Init()
{
    glm::ivec2 resolution = window->GetResolution();
    auto camera = GetSceneCamera();
    camera->SetOrthographic(0, (float)resolution.x, 0, (float)resolution.y, 0.01f, 400);
    camera->SetPosition(glm::vec3(0, 0, 50));
    camera->SetRotation(glm::vec3(0, 0, 0));
    camera->Update();
    GetCameraInput()->SetActive(false);

    shoot = false;
    maxDistance = 400;
    health = 100;
    scaleFactor = 1;
    score = 0;
    gameOver = false;
    firstBullet = false;

    //create health bar
    {
        baraViata.init(resolution.x - 285, resolution.y - 65, 250, 30);
        Mesh* healthBar = object2D::CreateRectangleKnowingLeftCorner("healthBar", glm::vec3(0, 0, 0), baraViata.width, baraViata.height, glm::vec3(1, 0, 0), true);
        AddMeshToList(healthBar);

        conturViata.init(resolution.x - 160, resolution.y - 50, 260, 40);
        Mesh* marginsHealth = object2D::CreateRectangle("marginsHealth", glm::vec3(0, 0, 0), conturViata.width, conturViata.height, glm::vec3(0, 0, 0), true);
        AddMeshToList(marginsHealth);
    }

    // create principal character
    {
        corp.init(resolution.x / 2, resolution.y / 2, 50);
        Mesh* body = object2D::CreateCircle(glm::vec3(1, 0, 0), "body", corp.radius, glm::vec3(0.30, 0, 0.05));
        AddMeshToList(body);

        conturCorp.init(resolution.x / 2, resolution.y / 2, 54);
        Mesh* marginsBody = object2D::CreateCircle(glm::vec3(0, 0, 0), "marginsBody", conturCorp.radius, glm::vec3(1, 0, 0));
        AddMeshToList(marginsBody);

        manaStanga.init(corp.x + 65 * cos((315 * PI) / 180), corp.y + 65 * sin((315 * PI) / 180), 22);
        Mesh* leftHand = object2D::CreateCircle(glm::vec3(1, 0, 0), "leftHand", manaStanga.radius, glm::vec3(1, 0, 0));
        AddMeshToList(leftHand);

        conturManaStanga.init(corp.x + 65 * cos((315 * PI) / 180), corp.y + 65 * sin((315 * PI) / 180), 26);
        Mesh* marginsLeftHand = object2D::CreateCircle(glm::vec3(0, 0, 0), "marginsLeftHand", conturManaStanga.radius, glm::vec3(1, 0, 0));
        AddMeshToList(marginsLeftHand);

        manaDreapta.init(corp.x + 65 * cos((225 * PI) / 180), corp.y + 65 * sin((225 * PI) / 180), 22);
        Mesh* rightHand = object2D::CreateCircle(glm::vec3(1, 0, 0), "rightHand", manaDreapta.radius, glm::vec3(1, 0, 0));
        AddMeshToList(rightHand);

        conturManaDreapta.init(corp.x + 65 * cos((315 * PI) / 180), corp.y + 65 * sin((315 * PI) / 180), 26);
        Mesh* marginsRightHand = object2D::CreateCircle(glm::vec3(0, 0, 0), "marginsRightHand", conturManaDreapta.radius, glm::vec3(1, 0, 0));
        AddMeshToList(marginsRightHand);


        glont.init(resolution.x / 2, resolution.y / 2, 20.f, 20.f);
        Mesh* ammo = object2D::CreateRectangle("ammo", glm::vec3(1, 0, 0), 20.f, 20.f, glm::vec3(0, 0, 0), true);
        AddMeshToList(ammo);
    }


    // create first 5 enemies and introduce one enemy mesh
    {
        mapTerrain.init(resolution.x / 2, resolution.y / 2, 2500.f, 2500.f);
        Mesh* bodyEnemy1 = object2D::CreateCircle(glm::vec3(0, 0, 0), "bodyEnemy1", 50, glm::vec3(1, 0, 0));
        AddMeshToList(bodyEnemy1);

        Mesh* leftEyeEnemy1 = object2D::CreateCircle(glm::vec3(1, 0, 0), "leftEyeEnemy1", 12, glm::vec3(1, 0, 0));
        AddMeshToList(leftEyeEnemy1);

        Mesh* rightEyeEnemy1 = object2D::CreateCircle(glm::vec3(1, 0, 0), "rightEyeEnemy1", 12, glm::vec3(1, 0, 0));
        AddMeshToList(rightEyeEnemy1);

        lastSpawn = clock();
        for (int i = 0; i < 5; i++) {
            float decide = random(0, 1);
            float x, y;
            if (decide == 0) {
                y = randomYOutOfMap(mapTerrain);
                x = randomX(mapTerrain);
            }
            else
            {
                y = randomY(mapTerrain);
                x = randomXOutOfMap(mapTerrain);
            }
            corpInamic1.init(x, y, 50);
            ochiStangInamic1.init(corpInamic1.x + 30 * cos((315 * PI) / 180), corpInamic1.y + 30 * sin((315 * PI) / 180), 12);
            ochiDreptInamic1.init(corpInamic1.x + 30 * cos((225 * PI) / 180), corpInamic1.y + 30 * sin((225 * PI) / 180), 12);
            Enemy inamic;
            enemies.push_back(inamic.newEnemy(corpInamic1, ochiStangInamic1, ochiDreptInamic1, random(100, 250)));
        }


    }

    //create obstacles
    {
        obstacolOriginal.init(0, 0, 100, 100);
        Mesh* obstacle = object2D::CreateRectangle("obstacle", glm::vec3(0, 0, 0), 100, 100, glm::vec3(1, 0.5, 0), true);
        AddMeshToList(obstacle);

        GameObjectRectangle obstacolAux;
        obstacles.push_back(obstacolAux.newObstacle(200, resolution.y + 400, 700.f, 600.f));
        obstacles.push_back(obstacolAux.newObstacle(resolution.x, resolution.y, 350.f, 300.f));
        obstacles.push_back(obstacolAux.newObstacle(-50, -150, 150.f, 800.f));
        obstacles.push_back(obstacolAux.newObstacle(150, -475, 400.f, 150.f));
        obstacles.push_back(obstacolAux.newObstacle(1200, -500, 300.f, 350.f));
        obstacles.push_back(obstacolAux.newObstacle(640, -860, 2500.f, 60.f));
        obstacles.push_back(obstacolAux.newObstacle(640, 1610, 2500.f, 60.f));
        obstacles.push_back(obstacolAux.newObstacle(-580, 360, 60.f, 2500.f));
        obstacles.push_back(obstacolAux.newObstacle(1860, 360, 60.f, 2500.f));

    }

    //create map 
    {
        mapTerrain.init(resolution.x / 2, resolution.y / 2, 2500.f, 2500.f);
        Mesh* terrain = object2D::CreateRectangle("terrain", glm::vec3(0, 0, 0), mapTerrain.width, mapTerrain.height, glm::vec3(1, 0.95, 0.80), true);
        AddMeshToList(terrain);
    }
}



void Tema1::FrameStart()
{
    // Clears the color buffer (using the previously set color) and depth buffer
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glm::ivec2 resolution = window->GetResolution();

    // Sets the screen area where to draw
    glViewport(0, 0, resolution.x, resolution.y);
}


void Tema1::Update(float deltaTimeSeconds)
{

    //health bar
    {
        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(baraViata.x, baraViata.y);
        modelMatrix = modelMatrix * transform2D::Scale(scaleFactor, 1);
        RenderMesh2D(meshes["healthBar"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(conturViata.x, conturViata.y);
        RenderMesh2D(meshes["marginsHealth"], shaders["VertexColor"], modelMatrix);
    }

  
    //character
    {
        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(corp.x, corp.y);
        RenderMesh2D(meshes["body"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(conturCorp.x, conturCorp.y);
        RenderMesh2D(meshes["marginsBody"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(manaStanga.x, manaStanga.y);
        RenderMesh2D(meshes["leftHand"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(conturManaStanga.x, conturManaStanga.y);
        RenderMesh2D(meshes["marginsLeftHand"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(manaDreapta.x, manaDreapta.y);
        RenderMesh2D(meshes["rightHand"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(conturManaDreapta.x, conturManaDreapta.y);
        RenderMesh2D(meshes["marginsRightHand"], shaders["VertexColor"], modelMatrix);
    }


    //ammo
    {
        // daca nu se loveste de niciun obstacol si nu depaseste distanta maxima isi continua traiectoria
        if (shoot == true && glm::length(glm::vec2(glont.x, glont.y) - glm::vec2(corp.x, corp.y)) < maxDistance
            && !CheckColisionAmmoObstacles(glont, obstacles) && !gameOver
            ) {
            glont.y = glont.y - sin(radiansAux) * deltaTimeSeconds * 800;
            glont.x = glont.x - cos(radiansAux) * deltaTimeSeconds * 800;
        }
        else {
            glont.y = corp.y;
            glont.x = corp.x;
            shoot = false;
        }

        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(glont.x, glont.y);
        modelMatrix = modelMatrix * transform2D::Rotate(radiansAux);
        RenderMesh2D(meshes["ammo"], shaders["VertexColor"], modelMatrix);
    }

    //enemy
    {
        for (int i = 0; i < enemies.size(); i++) {

            double unghi;
            unghi = atan2((enemies[i].body.y - corp.y), enemies[i].body.x - corp.x);

            //verific ca inamicul sa nu se ciocneasca cu peretii
            /*if (
                !CheckColision(enemyes[i].body.nextPos(enemyes[i].body.x - cos(unghi) * deltaTimeSeconds * enemyes[i].speed, enemyes[i].body.y - sin(unghi) * deltaTimeSeconds * enemyes[i].speed), obstacles[obstacles.size()-1])
                && !CheckColision(enemyes[i].body.nextPos(enemyes[i].body.x - cos(unghi) * deltaTimeSeconds * enemyes[i].speed, enemyes[i].body.y - sin(unghi) * deltaTimeSeconds * enemyes[i].speed), obstacles[obstacles.size() - 2])
                && !CheckColision(enemyes[i].body.nextPos(enemyes[i].body.x - cos(unghi) * deltaTimeSeconds * enemyes[i].speed, enemyes[i].body.y - sin(unghi) * deltaTimeSeconds * enemyes[i].speed), obstacles[obstacles.size() - 3])
                && !CheckColision(enemyes[i].body.nextPos(enemyes[i].body.x - cos(unghi) * deltaTimeSeconds * enemyes[i].speed, enemyes[i].body.y - sin(unghi) * deltaTimeSeconds * enemyes[i].speed), obstacles[obstacles.size() - 4])
                    ) {*/
            enemies[i].body.y = enemies[i].body.y - sin(unghi) * deltaTimeSeconds * enemies[i].speed;
            enemies[i].body.x = enemies[i].body.x - cos(unghi) * deltaTimeSeconds * enemies[i].speed;
            //}

            enemies[i].leftEye.modifyPos(-cos(unghi + (45 * M_PI) / 180) * 30 + enemies[i].body.x, -sin(unghi + (45 * M_PI) / 180) * 30 + enemies[i].body.y);
            enemies[i].rightEye.modifyPos(-cos(unghi - (45 * M_PI) / 180) * 30 + enemies[i].body.x, -sin(unghi - (45 * M_PI) / 180) * 30 + enemies[i].body.y);
        
            // verific coliziunea inre inamic si glont
            if (CheckColision(enemies[i].body, glont)) {

                //se sterge inamicul lovit
                enemies.erase(enemies.begin() + i);
                
                shoot = false;
                score++;
                cout << "Your current score is " << score << endl;
            }
        }

        // daca inamicii ranesc jucatorul
        for (int i = 0; i < enemies.size(); i++) {
            if (CheckColisionCharacterEnemy(conturCorp, enemies[i].body)
                || CheckColisionCharacterEnemy(conturManaStanga, enemies[i].body)
                || CheckColisionCharacterEnemy(conturManaDreapta, enemies[i].body)
                ) {
                
                enemies.erase(enemies.begin() + i);

                if (scaleFactor > 0.01) {
                    scaleFactor = scaleFactor - 0.2;
                    if (scaleFactor < 0.01)
                        gameOver = true;
                }
            }

            // verific daca au trecut cele 10 secunde si daca au trecut mai adaug 5 inamici
            now = clock();
            double time_taken = double(now - lastSpawn) / double(CLOCKS_PER_SEC);
            if (time_taken > 10) {
                for (int i = 0; i < 5; i++) {
                    float decide = random(0, 1);
                    float x, y;
                    if (decide == 0) {
                        y = randomYOutOfMap(mapTerrain);
                        x = randomX(mapTerrain);
                    }
                    else
                    {
                        y = randomY(mapTerrain);
                        x = randomXOutOfMap(mapTerrain);
                    }
                    corpInamic1.init(x, y, 50);
                    ochiStangInamic1.init(corpInamic1.x + 30 * cos((315 * PI) / 180), corpInamic1.y + 30 * sin((315 * PI) / 180), 12);
                    ochiDreptInamic1.init(corpInamic1.x + 30 * cos((225 * PI) / 180), corpInamic1.y + 30 * sin((225 * PI) / 180), 12);
                    Enemy inamic;
                    enemies.push_back(inamic.newEnemy(corpInamic1, ochiStangInamic1, ochiDreptInamic1, random(100, 250)));
                }
                lastSpawn = clock();
                cout << "Another 5 enemies have been spawned, now there are " << enemies.size() << endl;
            }

            //spawnez noii inamici si ii misc pe restul
            for (int i = 0; i < enemies.size(); i++) {
                modelMatrix = glm::mat3(1);
                modelMatrix = modelMatrix * transform2D::Translate(enemies[i].leftEye.x, enemies[i].leftEye.y);
                RenderMesh2D(meshes["leftEyeEnemy1"], shaders["VertexColor"], modelMatrix);

                modelMatrix = glm::mat3(1);
                modelMatrix = modelMatrix * transform2D::Translate(enemies[i].rightEye.x, enemies[i].rightEye.y);
                RenderMesh2D(meshes["rightEyeEnemy1"], shaders["VertexColor"], modelMatrix);

                modelMatrix = glm::mat3(1);
                modelMatrix = modelMatrix * transform2D::Translate(enemies[i].body.x, enemies[i].body.y);
                RenderMesh2D(meshes["bodyEnemy1"], shaders["VertexColor"], modelMatrix);
            }
            
        }
    }

    

    //create obstacles
    {

        for (int i = 0; i < obstacles.size(); i++) {
            float scaleX = obstacles[i].width / obstacolOriginal.width;
            float scaleY = obstacles[i].height / obstacolOriginal.height;
            modelMatrix = glm::mat3(1);
            modelMatrix = modelMatrix * transform2D::Translate(obstacles[i].x, obstacles[i].y);
            modelMatrix = modelMatrix * transform2D::Scale(scaleX, scaleY);
            RenderMesh2D(meshes["obstacle"], shaders["VertexColor"], modelMatrix);
        }
    }

    //map font
    {
        modelMatrix = glm::mat3(1);
        modelMatrix = modelMatrix * transform2D::Translate(mapTerrain.x, mapTerrain.y);
        RenderMesh2D(meshes["terrain"], shaders["VertexColor"], modelMatrix);
    }

}


void Tema1::FrameEnd()
{
}



void Tema1::OnInputUpdate(float deltaTime, int mods)
{
    //obiectele se vor misca doar daca nu se ating de personaj
    if (window->KeyHold(GLFW_KEY_W)
        && !CheckCollisionWithAllObstacles(conturCorp, moveObstacles(obstacles, 0, -300 * deltaTime))
        && !CheckCollisionWithAllObstacles(conturManaStanga, moveObstacles(obstacles, 0, -300 * deltaTime))
        && !CheckCollisionWithAllObstacles(conturManaDreapta, moveObstacles(obstacles, 0, -300 * deltaTime))
        && !gameOver
        ) {
        obstacles = moveObstacles(obstacles, 0, -300 * deltaTime);
        enemies = moveEnemyes(enemies, 0, -300 * deltaTime);
        mapTerrain.modifyPos(mapTerrain.x, mapTerrain.y - 300 * deltaTime);
    }
    if (window->KeyHold(GLFW_KEY_A)
        && !CheckCollisionWithAllObstacles(conturCorp, moveObstacles(obstacles, 300 * deltaTime, 0))
        && !CheckCollisionWithAllObstacles(conturManaStanga, moveObstacles(obstacles, 300 * deltaTime, 0))
        && !CheckCollisionWithAllObstacles(conturManaDreapta, moveObstacles(obstacles, 300 * deltaTime, 0))
        && !gameOver
        ) {
        obstacles = moveObstacles(obstacles, 300 * deltaTime, 0);
        enemies = moveEnemyes(enemies, 300 * deltaTime, 0);
        mapTerrain.modifyPos(mapTerrain.x + 300 * deltaTime, mapTerrain.y);
    }
    if (window->KeyHold(GLFW_KEY_S)
        && !CheckCollisionWithAllObstacles(conturCorp, moveObstacles(obstacles, 0, 300 * deltaTime))
        && !CheckCollisionWithAllObstacles(conturManaDreapta, moveObstacles(obstacles, 0, 300 * deltaTime))
        && !CheckCollisionWithAllObstacles(conturManaStanga, moveObstacles(obstacles, 0, 300 * deltaTime))
        && !gameOver
        ) {
        obstacles = moveObstacles(obstacles, 0, 300 * deltaTime);
        enemies = moveEnemyes(enemies, 0, 300 * deltaTime);
        mapTerrain.modifyPos(mapTerrain.x, mapTerrain.y + 300 * deltaTime);
    }
    if (window->KeyHold(GLFW_KEY_D)
        && !CheckCollisionWithAllObstacles(conturCorp, moveObstacles(obstacles, -300 * deltaTime, 0))
        && !CheckCollisionWithAllObstacles(conturManaDreapta, moveObstacles(obstacles, -300 * deltaTime, 0))
        && !CheckCollisionWithAllObstacles(conturManaStanga, moveObstacles(obstacles, -300 * deltaTime, 0))
        && !gameOver
        ) {
        obstacles = moveObstacles(obstacles, -300 * deltaTime, 0);
        enemies = moveEnemyes(enemies, -300 * deltaTime, 0);
        mapTerrain.modifyPos(mapTerrain.x - 300 * deltaTime, mapTerrain.y);
    }
}


void Tema1::OnKeyPress(int key, int mods)
{
    // Add key press event
}


void Tema1::OnKeyRelease(int key, int mods)
{
    // Add key release event

}


void Tema1::OnMouseMove(int mouseX, int mouseY, int deltaX, int deltaY)
{
    // Add mouse move event

    // pe baza unghiului dintre centrul corpului si mouse, orientez mainile caracterului
    radians = atan2(-(corp.y - mouseY), corp.x - mouseX);
    if (!CheckCollisionWithAllObstacles(conturManaStanga.nextPos(-cos(radians + (45 * M_PI) / 180) * 65 + corp.x, -sin(radians + (45 * M_PI) / 180) * 65 + corp.y), obstacles)
        && !CheckCollisionWithAllObstacles(conturManaDreapta.nextPos(-cos(radians - (45 * M_PI) / 180) * 65 + corp.x, -sin(radians - (45 * M_PI) / 180) * 65 + corp.y), obstacles)
        && !gameOver
        ) {
        manaStanga.modifyPos(-cos(radians + (45 * M_PI) / 180) * 65 + corp.x, -sin(radians + (45 * M_PI) / 180) * 65 + corp.y);
        conturManaStanga.modifyPos(-cos(radians + (45 * M_PI) / 180) * 65 + corp.x, -sin(radians + (45 * M_PI) / 180) * 65 + corp.y);
        manaDreapta.modifyPos(-cos(radians - (45 * M_PI) / 180) * 65 + corp.x, -sin(radians - (45 * M_PI) / 180) * 65 + corp.y);
        conturManaDreapta.modifyPos(-cos(radians - (45 * M_PI) / 180) * 65 + corp.x, -sin(radians - (45 * M_PI) / 180) * 65 + corp.y);
    }
}


void Tema1::OnMouseBtnPress(int mouseX, int mouseY, int button, int mods)
{
    // Add mouse button press eventa
    if (button == 1) {
        if (firstBullet == false) {
            shoot = true;
            radiansAux = radians;
            firstBullet = true;
            lastAmmo = clock();
        }
        else {
            timeAmmo = clock();
            double time_taken = double(timeAmmo - lastAmmo) / double(CLOCKS_PER_SEC);
            if (shoot == false && time_taken >= 0.5) {
                shoot = true;
                radiansAux = radians;
                lastAmmo = clock();
            }
        }
    }
}


void Tema1::OnMouseBtnRelease(int mouseX, int mouseY, int button, int mods)
{
    // Add mouse button release event
}


void Tema1::OnMouseScroll(int mouseX, int mouseY, int offsetX, int offsetY)
{
}


void Tema1::OnWindowResize(int width, int height)
{

}
