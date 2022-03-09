#pragma once

#include "components/simple_scene.h"
#include "components/transform.h"
#include "lab_m1/Tema2/lab_camera.h"


namespace m1
{
    class Tema2 : public gfxc::SimpleScene
    {
    public:
        class GameObjectCuboid {
        public:
            float x;
            float y;
            float z;
            
            float length;
            float width;
            float height;

            void init(float x, float y, float z, float length, float width, float height) {
                this->x = x;
                this->y = y;
                this->z = z;
                this->length = length;
                this->width = width;
                this->height = height;
            }

            void modifyPos(float x, float z) {
                this->x = x;
                this->z = z;
            }

            GameObjectCuboid nextPos(float x, float z) {
                GameObjectCuboid aux;
                aux.init(x, this->y, z, this->length, this->width, this->height);
                return aux;
            }

            GameObjectCuboid newCuboid(float x, float y, float z, float length, float width, float height) {
                GameObjectCuboid aux;
                aux.init(x, y, z, length, width, height);
                return aux;
            }
        };
        class Character {
        public:
            GameObjectCuboid head, body, rightSleeve, leftSleeve, rightArm, leftArm, trouser, trouserRightLeg, trouserLeftLeg;

            void moveCharacter(float addToX, float addToZ) {
                this->head.modifyPos(this->head.x + addToX, this->head.z + addToZ);
                this->body.modifyPos(this->body.x + addToX, this->body.z + addToZ);
                this->rightSleeve.modifyPos(this->rightSleeve.x + addToX, this->rightSleeve.z + addToZ);
                this->leftSleeve.modifyPos(this->leftSleeve.x + addToX, this->leftSleeve.z + addToZ);
                this->rightArm.modifyPos(this->rightArm.x + addToX, this->rightArm.z + addToZ);
                this->leftArm.modifyPos(this->leftArm.x + addToX, this->leftArm.z + addToZ);
                this->trouser.modifyPos(this->trouser.x + addToX, this->trouser.z + addToZ);
                this->trouserRightLeg.modifyPos(this->trouserRightLeg.x + addToX, this->trouserRightLeg.z + addToZ);
                this->trouserLeftLeg.modifyPos(this->trouserLeftLeg.x + addToX, this->trouserLeftLeg.z + addToZ);
            }
            Character nextPos(float x, float z) {
                Character aux;
                aux.head = this->head.nextPos(x, z);
                aux.body = this->body.nextPos(x, z);
                aux.rightSleeve = this->rightSleeve.nextPos(x, z);
                aux.leftSleeve = this->leftSleeve.nextPos(x, z);
                aux.rightArm = this->rightArm.nextPos(x, z);
                aux.leftArm = this->leftArm.nextPos(x, z);
                aux.trouser = this->trouser.nextPos(x, z);
                aux.trouserRightLeg = this->trouserRightLeg.nextPos(x, z);
                aux.trouserLeftLeg = this->trouserLeftLeg.nextPos(x, z);
                return aux;
            }
        };

        class Enemy {
        public:
            GameObjectCuboid head;
            GameObjectCuboid body;
            GameObjectCuboid leg1;
            GameObjectCuboid leg2;
            GameObjectCuboid leg3;
            GameObjectCuboid leg4;
            float infMargin;
            float supMargin;
            float direction;
            bool directionOX;
            bool directionOZ;

            void init(GameObjectCuboid head, GameObjectCuboid body, GameObjectCuboid leg1, GameObjectCuboid leg2,
                     GameObjectCuboid leg3, GameObjectCuboid leg4) {
                this->head = head;
                this->body = body;
                this->leg1 = leg1;
                this->leg2 = leg2;
                this->leg3 = leg3;
                this->leg4 = leg4;
            }
        };


    public:
        Tema2();
        ~Tema2();

        void Init() override;

    private:
        void FrameStart() override;
        void Update(float deltaTimeSeconds) override;
        void FrameEnd() override;

        void RenderMesh(Mesh* mesh, Shader* shader, const glm::mat4& modelMatrix) override;
        void RenderSimpleMesh(Mesh* mesh, Shader* shader, const glm::mat4& modelMatrix);
        Mesh* CreateMesh(const char* name, const std::vector<VertexFormat>& vertices, const std::vector<unsigned int>& indices);
        void CreateCuboid(const char* name, float length, float width, float height, glm::vec3 color);
        void CreateCuboidAfterLeftCorner(const char* name, float length, float width, float height, glm::vec3 color);
        bool checkCollisionWithWalls(GameObjectCuboid obj, float addToX, float addToZ);
        void moveCharacter(float addToX, float addToY);
        void decideAngle();
        Enemy newEnemy(float x, float z, float infMargin, float supMargin, bool OX, bool OZ);
        Enemy moveEnemy(Enemy enemy, float distance);
        bool checkCuboidCollision(GameObjectCuboid obj1, GameObjectCuboid obj2);
        bool checkCollisionCharacterWalls(float nextPosX, float nextPosZ);

        void OnInputUpdate(float deltaTime, int mods) override;
        void OnKeyPress(int key, int mods) override;
        void OnKeyRelease(int key, int mods) override;
        void OnMouseMove(int mouseX, int mouseY, int deltaX, int deltaY) override;
        void OnMouseBtnPress(int mouseX, int mouseY, int button, int mods) override;
        void OnMouseBtnRelease(int mouseX, int mouseY, int button, int mods) override;
        void OnMouseScroll(int mouseX, int mouseY, int offsetX, int offsetY) override;
        void OnWindowResize(int width, int height) override;

    protected:
        implemented::myCamera* camera;
        glm::mat4 projectionMatrix;
        bool renderCameraTarget;

        // TODO(student): If you need any other class variables, define them here.
        int mapDecider;
        bool left, right, forward, downward, shoot, gameOver, gameWon;
        float angle, initialX, initialZ, initialAngle, scaleFactor, scaleFactorTimer;
        GameObjectCuboid head, body, rightSleeve, leftSleeve, rightArm , leftArm, trouser, trouserRightLeg, trouserLeftLeg, characterHitbox;
        GameObjectCuboid floor, ammo, wall1, healthBar, marginHealthBar, timeBar, marginTimeBar, finish;
        std::vector <GameObjectCuboid> character, walls;
        std::vector <Enemy> enemies;

    };
}   // namespace m1
