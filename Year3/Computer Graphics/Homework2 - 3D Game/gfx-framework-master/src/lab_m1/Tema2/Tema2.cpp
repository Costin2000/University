#include "lab_m1/Tema2/Tema2.h"
#include "lab_m1/Tema2/transform3D.h"

#include <vector>
#include <string>
#include <iostream>
#include <math.h> 
#include <time.h> 

using namespace std;
using namespace m1;


/*
 *  To find out more about `FrameStart`, `Update`, `FrameEnd`
 *  and the order in which they are called, see `world.cpp`.
 */

float cameraX;
float cameraY;
float cameraZ;

clock_t startOfTheGame, timeSpent, checkForSecond;

void Tema2::CreateCuboid(const char* name, float length, float width, float height, glm::vec3 color) {
    
    vector<VertexFormat> vertices
    {
        VertexFormat(glm::vec3(-length/2, -height / 2,  width / 2), color),
        VertexFormat(glm::vec3(length / 2, -height / 2,  width / 2), color),
        VertexFormat(glm::vec3(-length / 2,  height / 2,  width / 2), color),
        VertexFormat(glm::vec3(length / 2,  height / 2,  width / 2), color),
        VertexFormat(glm::vec3(-length / 2, -height / 2, -width / 2), color),
        VertexFormat(glm::vec3(length / 2, -height / 2, -width / 2), color),
        VertexFormat(glm::vec3(-length / 2,  height / 2, -width / 2), color),
        VertexFormat(glm::vec3(length / 2,  height / 2, -width / 2), color),

    };

    vector<unsigned int> indices =
    {
        0, 1, 2,        1, 3, 2,
        2, 3, 7,        2, 7, 6,
        1, 7, 3,        1, 5, 7,
        6, 7, 4,        7, 5, 4,
        0, 4, 1,        1, 4, 5,
        2, 6, 4,        0, 2, 4,

    };

    CreateMesh(name, vertices, indices);  
}

void Tema2::CreateCuboidAfterLeftCorner(const char* name, float length, float width, float height, glm::vec3 color) {

    vector<VertexFormat> vertices
    {
        VertexFormat(glm::vec3(0, 0,  0), color),
        VertexFormat(glm::vec3(length, 0,  0), color),
        VertexFormat(glm::vec3(0,  height,  0), color),
        VertexFormat(glm::vec3(length,  height,  0), color),
        VertexFormat(glm::vec3(0, 0, -width), color),
        VertexFormat(glm::vec3(length , 0, -width), color),
        VertexFormat(glm::vec3(0,  height, -width), color),
        VertexFormat(glm::vec3(length,  height, -width), color),

    };

    vector<unsigned int> indices =
    {
        0, 1, 2,        1, 3, 2,
        2, 3, 7,        2, 7, 6,
        1, 7, 3,        1, 5, 7,
        6, 7, 4,        7, 5, 4,
        0, 4, 1,        1, 4, 5,
        2, 6, 4,        0, 2, 4,

    };

    CreateMesh(name, vertices, indices);
}

void Tema2::moveCharacter(float addToX, float addToZ) {
    //head, body, rightSleeve, leftSleeve, rightArm, leftArm, trouser, trouserRightLeg, trouserLeftLeg;
    characterHitbox.modifyPos(characterHitbox.x + addToX, characterHitbox.z + addToZ);
    head.modifyPos(head.x + addToX , head.z + addToZ);
    body.modifyPos(body.x + addToX, body.z + addToZ);
    rightSleeve.modifyPos(rightSleeve.x + addToX, rightSleeve.z + addToZ);
    leftSleeve.modifyPos(leftSleeve.x + addToX, leftSleeve.z + addToZ);
    rightArm.modifyPos(rightArm.x + addToX, rightArm.z + addToZ);
    leftArm.modifyPos(leftArm.x + addToX, leftArm.z + addToZ);
    trouser.modifyPos(trouser.x + addToX, trouser.z + addToZ);
    trouserRightLeg.modifyPos(trouserRightLeg.x + addToX, trouserRightLeg.z + addToZ);
    trouserLeftLeg.modifyPos(trouserLeftLeg.x + addToX, trouserLeftLeg.z + addToZ);
}

Tema2::Enemy Tema2::moveEnemy(Enemy enemy, float distance) {
    
    if (enemy.directionOX) {
        if (enemy.infMargin < (enemy.leg1.x + distance * enemy.direction) && enemy.supMargin > (enemy.leg2.x + distance * enemy.direction)) {
            enemy.head.modifyPos(enemy.head.x + distance * enemy.direction, enemy.head.z);
            enemy.body.modifyPos(enemy.body.x + distance * enemy.direction, enemy.body.z);
            enemy.leg1.modifyPos(enemy.leg1.x + distance * enemy.direction, enemy.leg1.z);
            enemy.leg2.modifyPos(enemy.leg2.x + distance * enemy.direction, enemy.leg2.z);
            enemy.leg3.modifyPos(enemy.leg3.x + distance * enemy.direction, enemy.leg3.z);
            enemy.leg4.modifyPos(enemy.leg4.x + distance * enemy.direction, enemy.leg4.z);
        }
        else {
            enemy.direction = enemy.direction * (-1);
            enemy.head.modifyPos(enemy.head.x + distance * enemy.direction, enemy.head.z);
            enemy.body.modifyPos(enemy.body.x + distance * enemy.direction, enemy.body.z);
            enemy.leg1.modifyPos(enemy.leg1.x + distance * enemy.direction, enemy.leg1.z);
            enemy.leg2.modifyPos(enemy.leg2.x + distance * enemy.direction, enemy.leg2.z);
            enemy.leg3.modifyPos(enemy.leg3.x + distance * enemy.direction, enemy.leg3.z);
            enemy.leg4.modifyPos(enemy.leg4.x + distance * enemy.direction, enemy.leg4.z);
        }
    }
    else {
        if ((enemy.infMargin < (enemy.leg1.z + distance * enemy.direction)) && enemy.supMargin > (enemy.leg3.z + distance * enemy.direction)) {
            enemy.head.modifyPos(enemy.head.x, enemy.head.z + distance * enemy.direction);
            enemy.body.modifyPos(enemy.body.x, enemy.body.z + distance * enemy.direction);
            enemy.leg1.modifyPos(enemy.leg1.x, enemy.leg1.z + distance * enemy.direction);
            enemy.leg2.modifyPos(enemy.leg2.x, enemy.leg2.z + distance * enemy.direction);
            enemy.leg3.modifyPos(enemy.leg3.x, enemy.leg3.z + distance * enemy.direction);
            enemy.leg4.modifyPos(enemy.leg4.x, enemy.leg4.z + distance * enemy.direction);
        }
        else {
            enemy.direction = enemy.direction * (-1);
            enemy.head.modifyPos(enemy.head.x, enemy.head.z + distance * enemy.direction);
            enemy.body.modifyPos(enemy.body.x, enemy.body.z + distance * enemy.direction);
            enemy.leg1.modifyPos(enemy.leg1.x, enemy.leg1.z + distance * enemy.direction);
            enemy.leg2.modifyPos(enemy.leg2.x, enemy.leg2.z + distance * enemy.direction);
            enemy.leg3.modifyPos(enemy.leg3.x, enemy.leg3.z + distance * enemy.direction);
            enemy.leg4.modifyPos(enemy.leg4.x, enemy.leg4.z + distance * enemy.direction);
        }
    }
    return enemy;
}

Tema2::Enemy Tema2::newEnemy(float x, float z, float infMargin, float supMargin, bool OX, bool OZ) {
    Enemy enemy;
    enemy.head.init(x, 1.75, z, 0.5, 0.5, 0.5);
    enemy.body.init(x, 0.75, z, 0.6, 0.6, 1.3);
    enemy.leg1.init(x - 0.35, 0.3, z + 0.35, 0.2, 0.2, 0.6);
    enemy.leg2.init(x + 0.35, 0.3, z + 0.35, 0.2, 0.2, 0.6);
    enemy.leg3.init(x + 0.35, 0.3, z - 0.35, 0.2, 0.2, 0.6);
    enemy.leg4.init(x - 0.35, 0.3, z-  0.35, 0.2, 0.2, 0.6);
    enemy.direction = 1;
    enemy.infMargin = infMargin;
    enemy.supMargin = supMargin;
    enemy.directionOX = OX;
    enemy.directionOZ = OZ;
    return enemy;
}

bool Tema2::checkCuboidCollision(GameObjectCuboid obj1, GameObjectCuboid obj2) {

    if (obj1.x - obj1.length / 2 <= obj2.x + obj2.length / 2 && obj1.x + obj1.length / 2 >= obj2.x - obj2.length / 2 &&
        obj1.y - obj1.height / 2 <= obj2.y + obj2.height / 2 && obj1.y + obj1.height / 2 >= obj2.y - obj2.height / 2 &&
        obj1.z - obj1.width / 2 <= obj2.z + obj2.width / 2 && obj1.z + obj1.width / 2 >= obj2.z - obj2.width / 2) {
        return true;
    }
    return false;
}


bool Tema2::checkCollisionCharacterWalls(float addToX, float addToZ) {

    for (int i = 0; i < walls.size(); i++) {
        if (checkCuboidCollision(characterHitbox.nextPos(characterHitbox.x + addToX, characterHitbox.z + addToZ), walls[i])) {
            return true;
        }
    }
    return false;
}

bool Tema2::checkCollisionWithWalls(GameObjectCuboid obj, float addToX, float addToZ) {
    for (int i = 0; i < walls.size(); i++) {
        if (checkCuboidCollision(obj.nextPos(obj.x + addToX, obj.z + addToZ), walls[i])) {
            return true;
        }
    }
    return false;
}


void Tema2::decideAngle() {
    if (left && forward && !right && !downward)
        angle = RADIANS(45);
    if (right && forward && !left && !downward)
        angle = RADIANS(-45);
    if (left && downward && !forward && !right)
        angle = RADIANS(135);
    if (right && downward && !forward && !left)
        angle = -RADIANS(135);
    if(left && !forward && !downward && !right) 
        angle = RADIANS(90);
    if (right && !forward && !downward && !left)
        angle =  - RADIANS(90);
    if (forward && !left && !right && !downward)
        angle = RADIANS(0);
    if (downward && !left && !right && !forward)
        angle = RADIANS(180);
    if (!left && !right && !forward && !downward)
        angle = RADIANS(0);
}

Tema2::Tema2()
{
}


Tema2::~Tema2()
{
}


void Tema2::Init()
{
    renderCameraTarget = false;

    left = false;
    right = false;
    forward = false;
    downward = false;
    shoot = false;
    gameWon = false;
    initialX = 0;
    initialZ = 0;
    initialAngle = 0;
    angle = 0;
    scaleFactor = 1;
    scaleFactorTimer = 1;
    gameOver = false;
    startOfTheGame = clock();
    checkForSecond = clock();

    cameraX = 0;
    cameraY = 5;
    cameraZ = 3;

    camera = new implemented::myCamera();
    camera->Set(glm::vec3(cameraX, cameraY, cameraZ), glm::vec3(0, 2, 0), glm::vec3(0, 1, 0));

    // Create the character
    {
        characterHitbox.init(0, 1, 0, 1, 1, 2);

        head.init(0, 2, 0, 0.5f, 0.25f, 0.5f);
        CreateCuboid("head", head.length, head.width, head.height, glm::vec3 (0.94, 0.87, 0.80));
        character.push_back(head);

        body.init(0, 1.25, 0, 0.5f, 0.25f, 0.8);
        CreateCuboid("body", body.length, body.width, body.height, glm::vec3(0.69, 0.00, 0.16));
        character.push_back(body);

        rightSleeve.init(0.40, 1.5, 0, 0.2f, 0.25f, 0.3);
        CreateCuboid("rightSleeve", rightSleeve.length, rightSleeve.width, rightSleeve.height, glm::vec3(0.69, 0.00, 0.16));
        character.push_back(rightSleeve);

        leftSleeve.init(- 0.40, 1.5, 0, 0.2f, 0.25f, 0.3);
        CreateCuboid("leftSleeve", leftSleeve.length, leftSleeve.width, leftSleeve.height, glm::vec3(0.69, 0.00, 0.16));
        character.push_back(leftSleeve);

        rightArm.init(0.40, 1.10, 0, 0.2f, 0.25f, 0.5);
        CreateCuboid("rightArm", rightArm.length, rightArm.width, rightArm.height, glm::vec3 (0.94, 0.87, 0.80));
        character.push_back(rightArm);

        leftArm.init(-0.40, 1.10, 0, 0.2f, 0.25f, 0.5);
        CreateCuboid("leftArm", leftArm.length, leftArm.width, leftArm.height, glm::vec3(0.94, 0.87, 0.80));
        character.push_back(leftArm);

        trouser.init(0, 0.70, 0, 0.5f, 0.25f, 0.2);
        CreateCuboid("trouser", trouser.length, trouser.width, trouser.height, glm::vec3(0.36, 0.54, 0.66));
        character.push_back(trouser);

        trouserRightLeg.init(0.15, 0.3, 0, 0.2f, 0.25f, 0.6f);
        CreateCuboid("trouserRightLeg", trouserRightLeg.length, trouserRightLeg.width, trouserRightLeg.height, glm::vec3(0.36, 0.54, 0.66));
        character.push_back(trouserRightLeg);

        trouserLeftLeg.init(- 0.15, 0.3, 0, 0.2f, 0.25f, 0.6f);
        CreateCuboid("trouserLeftLeg", trouserLeftLeg.length, trouserLeftLeg.width, trouserLeftLeg.height, glm::vec3(0.36, 0.54, 0.66));
        character.push_back(trouserLeftLeg); 

    }

    //create the ammo
    {
        ammo.init(body.x, body.y, body.z, 0.15f, 0.15f, 0.15f);
        CreateCuboid("ammo", ammo.length, ammo.width, ammo.height, glm::vec3(0.69, 0.75, 0.10));
        character.push_back(ammo);
    }
    //create the floor
    {
        floor.init(0, -1, -45, 100, 100, 2);
        CreateCuboid("floor", floor.length, floor.width, floor.height, glm::vec3(0.55, 0.27, 0.04));
        character.push_back(floor);
    }
    mapDecider = 1 + (std::rand() % (3 - 1 + 1));

    if (mapDecider == 1) {
        //create the enemies
        {
            CreateCuboid("headEnemy", 0.5, 0.5, 0.5, glm::vec3(0.43, 0.54, 0.54));
            CreateCuboid("bodyEnemy", 0.6, 0.6, 1.3, glm::vec3(0.30, 0.38, 0.38)); 
            CreateCuboid("leg", 0.2, 0.2, 0.6, glm::vec3(0.43, 0.54, 0.54));

            enemies.push_back(newEnemy(-5, -10.5, -9.5, 1, true, false));
            enemies.push_back(newEnemy(-5, -21.5, -6, 1, true, false));
            enemies.push_back(newEnemy(-11, -10, -20, -3, false, true));
            enemies.push_back(newEnemy(10, -3.5, 4, 15, true, false));
            enemies.push_back(newEnemy(12, -10.5, 10, 18, true, false));
            enemies.push_back(newEnemy(21.5, -17.5, 17, 23.5, true, false));
        }


        //create the maze walls
        {
            //4
            CreateCuboid("wall1", 1, 1, 2, glm::vec3(0, 0, 0));
            wall1.init(0, 0, 0, 1, 1, 2);
            walls.push_back(wall1.newCuboid(2, 1, -5, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-2, 1, -5, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-5.5, 1, -8.5, 6, 1, 2));
            walls.push_back(wall1.newCuboid(-9, 1, -5, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-11, 1, -1.5, 3, 1, 2));
            walls.push_back(wall1.newCuboid(-13, 1, -12.5, 1, 23, 2));
            walls.push_back(wall1.newCuboid(-5.5, 1, -23.5, 14, 1, 2));
            walls.push_back(wall1.newCuboid(2, 1, -18, 1, 12, 2));
            walls.push_back(wall1.newCuboid(-5.5, 1, -16, 8, 8, 2));
            walls.push_back(wall1.newCuboid(4, 1, -8.5, 3, 1, 2));
            walls.push_back(wall1.newCuboid(6, 1, -7, 1, 4, 2));
            walls.push_back(wall1.newCuboid(10.5, 1, -1.5, 16, 1, 2));
            walls.push_back(wall1.newCuboid(18, 1, -3.5, 1, 3, 2));
            walls.push_back(wall1.newCuboid(14.5, 1, -5.5, 8, 1, 2));
            walls.push_back(wall1.newCuboid(10, 1, -7, 1, 4, 2));
            walls.push_back(wall1.newCuboid(14.5, 1, -8.5, 8, 1, 2));
            walls.push_back(wall1.newCuboid(19, 1, -12, 1, 8, 2));
            walls.push_back(wall1.newCuboid(9, 1, -12.5, 13, 1, 2));
            walls.push_back(wall1.newCuboid(15, 1, -16.5, 1, 7, 2));
            walls.push_back(wall1.newCuboid(19, 1, -19.5, 7, 1, 2));
            walls.push_back(wall1.newCuboid(22.25, 1, -15.5, 5.5, 1, 2));
            walls.push_back(wall1.newCuboid(24.5, 1, -18, 1, 4, 2));
            
        }

        //create finish point
        {
            CreateCuboid("finish", 1, 1, 1, glm::vec3(0, 1, 0));
            finish.init(23, 0.5, -23, 1, 1, 1);
        }
    }

    if (mapDecider == 2) {

        //create the enemies
        {
            CreateCuboid("headEnemy", 0.5, 0.5, 0.5, glm::vec3(0.43, 0.54, 0.54));
            CreateCuboid("bodyEnemy", 0.6, 0.6, 1.3, glm::vec3(0.30, 0.38, 0.38)); /*1.00, 0.49, 0.00*/
            CreateCuboid("leg", 0.2, 0.2, 0.6, glm::vec3(0.43, 0.54, 0.54));

            enemies.push_back(newEnemy(-13.5, -12.5, -19.5, -10.5, false, true));
            enemies.push_back(newEnemy(-8, -19.5, -11, -2, true, false));
            enemies.push_back(newEnemy(17.5, -16, -19, -14, false, true));
            enemies.push_back(newEnemy(10, -13.5, 4, 15, true, false));
            enemies.push_back(newEnemy(-7, -6.5, -8, -3, true, false));
            
        }

        //create the maze walls
        {
            CreateCuboid("wall1", 1, 1, 2, glm::vec3(0, 0, 0));
            wall1.init(0, 0, 0, 1, 1, 2);
            walls.push_back(wall1.newCuboid(-2.5, 1, -3, 1, 4, 2));
            walls.push_back(wall1.newCuboid(-6.5, 1, -4.5, 7, 1, 2));
            walls.push_back(wall1.newCuboid(-9.5, 1, -9, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-7, 1, -12.5, 4, 1, 2));
            walls.push_back(wall1.newCuboid(-5.5, 1, -10, 1, 4, 2));
            walls.push_back(wall1.newCuboid(-3.5, 1, -8.5, 3, 1, 2));
            walls.push_back(wall1.newCuboid(-2.5, 1, -13, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-7, 1, -17.5, 10, 1, 2));
            walls.push_back(wall1.newCuboid(-11.5, 1, -11, 1, 12, 2));
            walls.push_back(wall1.newCuboid(-16, 1, -5.5, 8, 1, 2));
            walls.push_back(wall1.newCuboid(-18, 1, -9.5, 4, 1, 2));
            walls.push_back(wall1.newCuboid(-15.5, 1, -15, 1, 12, 2));
            walls.push_back(wall1.newCuboid(-7, 1, -21.5, 18, 1, 2));
            walls.push_back(wall1.newCuboid(2.5, 1, -18.5, 1, 7, 2));
            walls.push_back(wall1.newCuboid(2.5, 1, -6, 1, 10, 2));
            walls.push_back(wall1.newCuboid(11, 1, -11.5, 18, 1, 2));
            walls.push_back(wall1.newCuboid(9.5, 1, -15.5, 13, 1, 2));
            walls.push_back(wall1.newCuboid(19.5, 1, -16.5, 1, 9, 2));
            walls.push_back(wall1.newCuboid(15.5, 1, -18.5, 1, 5, 2));
            walls.push_back(wall1.newCuboid(17.5, 1, -20.5, 3, 1, 2));
        }

        //create finish point
        {
            CreateCuboid("finish", 1, 1, 1, glm::vec3(0, 1, 0));
            finish.init(-21.5, 0.5, -7.5, 1, 1, 1);
        }
    }

    if (mapDecider == 3) {

        //create the enemies
        {
            CreateCuboid("headEnemy", 0.5, 0.5, 0.5, glm::vec3(0.43, 0.54, 0.54));
            CreateCuboid("bodyEnemy", 0.6, 0.6, 1.3, glm::vec3(0.30, 0.38, 0.38)); /*1.00, 0.49, 0.00*/
            CreateCuboid("leg", 0.2, 0.2, 0.6, glm::vec3(0.43, 0.54, 0.54));

            enemies.push_back(newEnemy(-6, -18.5, -11, 1, true, false));
            enemies.push_back(newEnemy(0, -8, -17, -6, false, true));
            enemies.push_back(newEnemy(8, -9.5, 3, 14, true, false));
            enemies.push_back(newEnemy(12, -5.5, 9, 15, true, false));
            enemies.push_back(newEnemy(10, -13.5, 7, 13, true, false));
          
        }

        //create the maze walls
        {
            CreateCuboid("wall1", 1, 1, 2, glm::vec3(0, 0, 0));
            wall1.init(0, 0, 0, 1, 1, 2);
            walls.push_back(wall1.newCuboid(2.5, 1, -4, 1, 6, 2));
            walls.push_back(wall1.newCuboid(7, 1, -7.5, 10, 1, 2));
            walls.push_back(wall1.newCuboid(8.5, 1, -5, 1, 4, 2));
            walls.push_back(wall1.newCuboid(12, 1, -3.5, 6, 1, 2));
            walls.push_back(wall1.newCuboid(15.5, 1, -7, 1, 8, 2));
            walls.push_back(wall1.newCuboid(14.5, 1, -11.5, 3, 1, 2));
            walls.push_back(wall1.newCuboid(13.5, 1, -14, 1, 4, 2));
            walls.push_back(wall1.newCuboid(9.5, 1, -15.5, 7, 1, 2));
            walls.push_back(wall1.newCuboid(6.5, 1, -13.5, 1, 3, 2));
            walls.push_back(wall1.newCuboid(6, 1, -11.5, 8, 1, 2));
            walls.push_back(wall1.newCuboid(2.5, 1, -16, 1, 8, 2));
            walls.push_back(wall1.newCuboid(-2.5, 1, -9, 1, 16, 2));
            walls.push_back(wall1.newCuboid(-4, 1, -20.5, 14, 1, 2));
            walls.push_back(wall1.newCuboid(-7, 1, -16.5, 8, 1, 2));
        }

        //create finish point
        {
            CreateCuboid("finish", 1, 1, 1, glm::vec3(0, 1, 0));
            finish.init(-12.5, 0.5, -18.5, 1, 1, 1);
        }
    }
    
    {
        CreateCuboidAfterLeftCorner("healthBar", 1.5, 0.1, 0.1, glm::vec3(1, 0, 0));
        healthBar.init(1, 3.81, 0, 1.5, 0.1, 0.1);

        CreateCuboidAfterLeftCorner("marginHealthBar", 1.65, 0.1, 0.125, glm::vec3(1, 1, 1));
        marginHealthBar.init(0.95, 3.8, 0, 1.65, 0.1, 0.125);
        //marginHealthBar
    }

    {
        CreateCuboidAfterLeftCorner("timeBar", 1.5, 0.1, 0.1, glm::vec3(0, 0, 1));
        timeBar.init(-2.60, 3.81, 0, 1.5, 0.1, 0.1);

        CreateCuboidAfterLeftCorner("marginTimeBar", 1.65, 0.1, 0.125, glm::vec3(1, 1, 1));
        marginTimeBar.init(-2.7, 3.8, 0, 1.65, 0.1, 0.125);
        //marginHealthBar
    }
    
    
    projectionMatrix = glm::perspective(RADIANS(60), window->props.aspectRatio, 0.01f, 200.0f);

}

Mesh* Tema2::CreateMesh(const char* name, const std::vector<VertexFormat>& vertices, const std::vector<unsigned int>& indices)
{
    unsigned int VAO = 0;
    // Create the VAO and bind it
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    // Create the VBO and bind it
    unsigned int VBO;
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);

    // Send vertices data into the VBO buffer
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices[0]) * vertices.size(), &vertices[0], GL_STATIC_DRAW);

    // Create the IBO and bind it
    unsigned int IBO;
    glGenBuffers(1, &IBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IBO);

    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices[0]) * indices.size(), &indices[0], GL_STATIC_DRAW);


    // Set vertex position attribute
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(VertexFormat), 0);

    // Set vertex normal attribute
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(VertexFormat), (void*)(sizeof(glm::vec3)));

    // Set texture coordinate attribute
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, sizeof(VertexFormat), (void*)(2 * sizeof(glm::vec3)));

    // Set vertex color attribute
    glEnableVertexAttribArray(3);
    glVertexAttribPointer(3, 3, GL_FLOAT, GL_FALSE, sizeof(VertexFormat), (void*)(2 * sizeof(glm::vec3) + sizeof(glm::vec2)));
    // ========================================================================

    // Unbind the VAO
    glBindVertexArray(0);

    // Check for OpenGL errors
    CheckOpenGLError();

    // Mesh information is saved into a Mesh object
    meshes[name] = new Mesh(name);
    meshes[name]->InitFromBuffer(VAO, static_cast<unsigned int>(indices.size()));
    meshes[name]->vertices = vertices;
    meshes[name]->indices = indices;
    return meshes[name];
}


void Tema2::FrameStart()
{
    // Clears the color buffer (using the previously set color) and depth buffer
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glm::ivec2 resolution = window->GetResolution();
    // Sets the screen area where to draw
    glViewport(0, 0, resolution.x, resolution.y);
}


void Tema2::Update(float deltaTimeSeconds)
{
    

    glm::mat4 modelMatrix = glm::mat4(1);
    //move character
    {
        decideAngle();

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(head.x, head.y, head.z);
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["head"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(body.x, body.y, body.z);
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["body"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, rightSleeve.y, body.z + body.length/2 + rightSleeve.length/2);
        } else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, rightSleeve.y, body.z - body.length / 2 - rightSleeve.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(rightSleeve.x, rightSleeve.y, rightSleeve.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["rightSleeve"], shaders["VertexColor"], modelMatrix);
        
        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, leftSleeve.y, body.z - body.length / 2 - leftSleeve.length / 2);
        }
        else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, leftSleeve.y, body.z + body.length / 2 + leftSleeve.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(leftSleeve.x, leftSleeve.y, leftSleeve.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["leftSleeve"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, rightArm.y, body.z + body.length / 2 + rightArm.length / 2);
        }
        else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, rightArm.y, body.z - body.length / 2 - rightArm.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(rightArm.x, rightArm.y, rightArm.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["rightArm"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, leftArm.y, body.z - body.length / 2 - leftArm.length / 2);
        } else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(body.x, leftArm.y, body.z + body.length / 2 + leftArm.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(leftArm.x, leftArm.y, leftArm.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["leftArm"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(trouser.x, trouser.y, trouser.z);
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["trouser"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(trouser.x , trouserRightLeg.y, trouser.z + trouser.length/2 - trouserRightLeg.length/2);
        }
        else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(trouser.x, trouserRightLeg.y, trouser.z - trouser.length / 2 + trouserRightLeg.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(trouserRightLeg.x, trouserRightLeg.y, trouserRightLeg.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["trouserRightLeg"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        if (angle == -RADIANS(90)) {
            modelMatrix *= transform3D::Translate(trouser.x, trouserLeftLeg.y, trouser.z - trouser.length / 2 + trouserLeftLeg.length / 2);
        }
        else if (angle == RADIANS(90)) {
            modelMatrix *= transform3D::Translate(trouser.x, trouserLeftLeg.y, trouser.z + trouser.length / 2 - trouserLeftLeg.length / 2);
        }
        else {
            modelMatrix *= transform3D::Translate(trouserLeftLeg.x, trouserLeftLeg.y, trouserLeftLeg.z);
        }
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["trouserLeftLeg"], shaders["VertexColor"], modelMatrix);
        
    }

    //ammo
    {
        if (shoot == true && glm::length(glm::vec2(ammo.x, ammo.z) - glm::vec2(initialX, initialZ)) < 5 && !checkCollisionWithWalls(ammo, 0, 0)) {
            float newX = ammo.x - sin(initialAngle) * deltaTimeSeconds * 8;
            float newZ = ammo.z - cos(initialAngle) * deltaTimeSeconds * 8;
            ammo.modifyPos(newX, newZ);
        }
        else {
            ammo.modifyPos(body.x, body.z);
            shoot = false;
        }

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(ammo.x, ammo.y, ammo.z);
        modelMatrix *= transform3D::RotateOY(angle);
        RenderMesh(meshes["ammo"], shaders["VertexColor"], modelMatrix);
    }

    //draw enemies
    {
        for (int i = 0; i < enemies.size(); i++) {
            
            enemies[i] = moveEnemy(enemies[i], deltaTimeSeconds * 2);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].head.x, enemies[i].head.y, enemies[i].head.z);
            RenderMesh(meshes["headEnemy"], shaders["VertexColor"], modelMatrix);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].body.x, enemies[i].body.y, enemies[i].body.z);
            RenderMesh(meshes["bodyEnemy"], shaders["VertexColor"], modelMatrix);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].leg1.x, enemies[i].leg1.y, enemies[i].leg1.z);
            RenderMesh(meshes["leg"], shaders["VertexColor"], modelMatrix);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].leg2.x, enemies[i].leg2.y, enemies[i].leg2.z);
            RenderMesh(meshes["leg"], shaders["VertexColor"], modelMatrix);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].leg3.x, enemies[i].leg3.y, enemies[i].leg3.z);
            RenderMesh(meshes["leg"], shaders["VertexColor"], modelMatrix);

            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(enemies[i].leg4.x, enemies[i].leg4.y, enemies[i].leg4.z);
            RenderMesh(meshes["leg"], shaders["VertexColor"], modelMatrix);

            if (checkCuboidCollision(ammo, enemies[i].body)) {
                shoot = false;
                enemies.erase(enemies.begin() + i);
                ammo.modifyPos(body.x, body.z);
            }
        }
        for (int i = 0; i < enemies.size(); i++) {
            if (checkCuboidCollision(characterHitbox, enemies[i].body)) {
                if (scaleFactor - 0.33 > 0) {
                    scaleFactor -= 0.33;
                    if (scaleFactor < 0.33) {
                        scaleFactor = 0;
                        gameOver = true;
                        cout << "YOU LOST";
                    }
                }
            
                enemies.erase(enemies.begin() + i);
            }
        }
    }

    //draw walls
    {
        for (int i = 0; i < walls.size(); i++) {
            float scaleX = walls[i].length / wall1.length;
            float scaleZ = walls[i].width / wall1.width;
            
            modelMatrix = glm::mat4(1);
            modelMatrix *= transform3D::Translate(walls[i].x, walls[i].y, walls[i].z);
            modelMatrix *= transform3D::Scale(scaleX, 1, scaleZ);
            RenderMesh(meshes["wall1"], shaders["VertexColor"], modelMatrix);
        }
    }

    //draw finish
    {
        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(finish.x, finish.y, finish.z);
        RenderMesh(meshes["finish"], shaders["VertexColor"], modelMatrix);

        if (checkCuboidCollision(characterHitbox, finish) && !gameWon) {
            
            gameWon = true;
            cout << "You won the game!!!";
        }
    }

    //draw healthbar
    {
        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(healthBar.x, healthBar.y, healthBar.z);
        modelMatrix *= transform3D::RotateOX(- RADIANS(30));
        modelMatrix = modelMatrix * transform3D::Scale(scaleFactor, 1, 1);
        RenderMesh(meshes["healthBar"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(marginHealthBar.x, marginHealthBar.y, marginHealthBar.z);
        modelMatrix *= transform3D::RotateOX(-RADIANS(30));
        RenderMesh(meshes["marginHealthBar"], shaders["VertexColor"], modelMatrix);
    }

    timeSpent = clock();
    double time_taken = double(timeSpent - startOfTheGame) / double(CLOCKS_PER_SEC);

    if (time_taken > 60 && !gameOver && !gameWon) {
        cout << "GAME OVER! You've spent too much time!";
        scaleFactorTimer = 0;
        gameOver = true;
    }

    //timeSpent = clock();
    double secondPassed = double(timeSpent - checkForSecond) / double(CLOCKS_PER_SEC);
    if (!gameOver && !gameWon && secondPassed >= 1) {
        scaleFactorTimer -= 1.0f / 60;
        checkForSecond = timeSpent;
    }

    //draw timebar
    {
        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(timeBar.x, timeBar.y, timeBar.z);
        modelMatrix *= transform3D::RotateOX(-RADIANS(30));
        modelMatrix = modelMatrix * transform3D::Scale(scaleFactorTimer, 1, 1);
        RenderMesh(meshes["timeBar"], shaders["VertexColor"], modelMatrix);

        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(marginTimeBar.x, marginTimeBar.y, marginTimeBar.z);
        modelMatrix *= transform3D::RotateOX(-RADIANS(30));
        RenderMesh(meshes["marginTimeBar"], shaders["VertexColor"], modelMatrix);
    }
    

    //draw floor
    {
        modelMatrix = glm::mat4(1);
        modelMatrix *= transform3D::Translate(floor.x, floor.y, floor.z);
        RenderMesh(meshes["floor"], shaders["VertexColor"], modelMatrix);
    }

    

}


void Tema2::FrameEnd()
{
    DrawCoordinateSystem(camera->GetViewMatrix(), projectionMatrix);
}


void Tema2::RenderMesh(Mesh* mesh, Shader* shader, const glm::mat4& modelMatrix)
{
    if (!mesh || !shader || !shader->program)
        return;

    shader->Use();
    glUniformMatrix4fv(shader->loc_view_matrix, 1, GL_FALSE, glm::value_ptr(camera->GetViewMatrix()));
    glUniformMatrix4fv(shader->loc_projection_matrix, 1, GL_FALSE, glm::value_ptr(projectionMatrix));
    glUniformMatrix4fv(shader->loc_model_matrix, 1, GL_FALSE, glm::value_ptr(modelMatrix));

    mesh->Render();
}

void Tema2::RenderSimpleMesh(Mesh* mesh, Shader* shader, const glm::mat4& modelMatrix)
{
    if (!mesh || !shader || !shader->GetProgramID())
        return;

    glUseProgram(shader->program);

    GLint model_location = glGetUniformLocation(shader->GetProgramID(), "Model");

    glUniformMatrix4fv(model_location, 1, GL_FALSE, glm::value_ptr(modelMatrix));

    GLint view_location = glGetUniformLocation(shader->GetProgramID(), "View");
    glm::mat4 view_matrix = GetSceneCamera()->GetViewMatrix();
    glUniformMatrix4fv(view_location, 1, GL_FALSE, glm::value_ptr(view_matrix));

    glm::mat4 viewMatrix = GetSceneCamera()->GetViewMatrix();

    GLint projection_location = glGetUniformLocation(shader->GetProgramID(), "Projection");
    glm::mat4 projection_matrix = GetSceneCamera()->GetProjectionMatrix();
    glUniformMatrix4fv(projection_location, 1, GL_FALSE, glm::value_ptr(projection_matrix));

    glm::mat4 projectionMatrix = GetSceneCamera()->GetProjectionMatrix();

    glBindVertexArray(mesh->GetBuffers()->m_VAO);
    glDrawElements(mesh->GetDrawMode(), static_cast<int>(mesh->indices.size()), GL_UNSIGNED_INT, 0);
}


void Tema2::OnInputUpdate(float deltaTime, int mods)
{
    float cameraSpeed = 2.0f;

    if (window->KeyHold(GLFW_KEY_W) && !checkCollisionCharacterWalls(0, -deltaTime * cameraSpeed) && !gameOver && !gameWon) {
        forward = true;
        camera->MoveForward(deltaTime * cameraSpeed);
        moveCharacter(0, -deltaTime * cameraSpeed);
        healthBar.modifyPos(healthBar.x, healthBar.z - deltaTime * cameraSpeed);
        marginHealthBar.modifyPos(marginHealthBar.x, marginHealthBar.z - deltaTime * cameraSpeed);
        timeBar.modifyPos(timeBar.x, timeBar.z - deltaTime * cameraSpeed);
        marginTimeBar.modifyPos(marginTimeBar.x, marginTimeBar.z - deltaTime * cameraSpeed);
    }
    else {
        forward = false;
    }

    if (window->KeyHold(GLFW_KEY_A)  && !checkCollisionCharacterWalls(-deltaTime * cameraSpeed, 0) && !gameOver && !gameWon) {
        left = true;
        camera->TranslateRight(-deltaTime * cameraSpeed);
        moveCharacter(-deltaTime * cameraSpeed, 0);
        healthBar.modifyPos(healthBar.x - deltaTime * cameraSpeed, healthBar.z);
        marginHealthBar.modifyPos(marginHealthBar.x - deltaTime * cameraSpeed, marginHealthBar.z);
        timeBar.modifyPos(timeBar.x - deltaTime * cameraSpeed, timeBar.z);
        marginTimeBar.modifyPos(marginTimeBar.x - deltaTime * cameraSpeed, marginTimeBar.z);
    }
    else {
        left = false;
    }

    if (window->KeyHold(GLFW_KEY_S) && !checkCollisionCharacterWalls(0, deltaTime * cameraSpeed) && !gameOver && !gameWon) {
        downward = true;
        camera->MoveForward(-deltaTime * cameraSpeed);
        moveCharacter(0, deltaTime * cameraSpeed);
        healthBar.modifyPos(healthBar.x, healthBar.z + deltaTime * cameraSpeed);
        marginHealthBar.modifyPos(marginHealthBar.x, marginHealthBar.z + deltaTime * cameraSpeed);
        timeBar.modifyPos(timeBar.x, timeBar.z + deltaTime * cameraSpeed);
        marginTimeBar.modifyPos(marginTimeBar.x, marginTimeBar.z + deltaTime * cameraSpeed);
    }
    else {
        downward = false;
    }

    if (window->KeyHold(GLFW_KEY_D) && !checkCollisionCharacterWalls(deltaTime * cameraSpeed, 0) && !gameOver && !gameWon) {
        right = true;
        camera->TranslateRight(deltaTime * cameraSpeed);
        moveCharacter(deltaTime * cameraSpeed, 0);
        healthBar.modifyPos(healthBar.x + deltaTime * cameraSpeed, healthBar.z);
        marginHealthBar.modifyPos(marginHealthBar.x + deltaTime * cameraSpeed, marginHealthBar.z);
        timeBar.modifyPos(timeBar.x + deltaTime * cameraSpeed, timeBar.z);
        marginTimeBar.modifyPos(marginTimeBar.x + deltaTime * cameraSpeed, marginTimeBar.z);
    }
    else {
        right = false;
    }




}


void Tema2::OnKeyPress(int key, int mods)
{

}


void Tema2::OnKeyRelease(int key, int mods)
{

}


void Tema2::OnMouseMove(int mouseX, int mouseY, int deltaX, int deltaY)
{

}


void Tema2::OnMouseBtnPress(int mouseX, int mouseY, int button, int mods)
{
    if (button == 1 && shoot == false) {
        shoot = true;
        initialX = ammo.x;
        initialZ = ammo.z;
        initialAngle = angle;
    }
    
}


void Tema2::OnMouseBtnRelease(int mouseX, int mouseY, int button, int mods)
{

}


void Tema2::OnMouseScroll(int mouseX, int mouseY, int offsetX, int offsetY)
{
}


void Tema2::OnWindowResize(int width, int height)
{
}
