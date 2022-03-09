#pragma once

#include "components/simple_scene.h"
#include "core/engine.h"
#include "utils/gl_utils.h"
#include <vector>
#include "lab_m1/Tema1/transform2D.h"
#include <chrono>

using namespace std;

namespace m1
{
    class Tema1 : public gfxc::SimpleScene
    {

    public:
        class GameObjectRectangle {
        public:
            float x;
            float y;
            float width;
            float height;

            void init (float x, float y, float width, float height) {
                this->x = x;
                this->y = y;
                this->width = width;
                this->height = height;
            }

            void modifyPos(float x, float y) {
                this->x = x;
                this->y = y;
            }

            GameObjectRectangle nextPos(float x, float y) {
                GameObjectRectangle aux;
                aux.init(x, y, this->width, this->height);
                return aux;
            }

            GameObjectRectangle newObstacle(float x, float y, float width, float height) {
                GameObjectRectangle aux;
                aux.init(x, y, width, height);
                return aux;
            }

        };

        class GameObjectCircle {
        public:
            float x;
            float y;
            float radius;

            void init (float x, float y, float radius) {
                this->x = x;
                this->y = y;
                this->radius = radius;
            }

            void modifyPos(float x, float y) {
                this->x = x;
                this->y = y;
            }

            GameObjectCircle nextPos(float x, float y) {
                GameObjectCircle aux;
                aux.init(x, y, this->radius);
                return aux;
            }
        };

        class Enemy {
        public:
            GameObjectCircle body;
            GameObjectCircle leftEye;
            GameObjectCircle rightEye;
            int speed;
            
            
            void init(GameObjectCircle body, GameObjectCircle leftEye, GameObjectCircle rightEye, int speed) {
                this->body = body;
                this->leftEye = leftEye;
                this->rightEye = rightEye;
                this->speed = speed;
            }

            Enemy newEnemy(GameObjectCircle body, GameObjectCircle leftEye, GameObjectCircle rightEye, int speed) {
                Enemy aux;
                aux.init(body, leftEye, rightEye, speed);
                return aux;
            }

            void newSpeed(int speed) {
                this->speed = speed;
            }
        };

       

    public:
        Tema1();
        ~Tema1();

        void Init() override;

    private:
        void FrameStart() override;
        void Update(float deltaTimeSeconds) override;
        void FrameEnd() override;
        void OnInputUpdate(float deltaTime, int mods) override;
        void OnKeyPress(int key, int mods) override;
        void OnKeyRelease(int key, int mods) override;
        void OnMouseMove(int mouseX, int mouseY, int deltaX, int deltaY) override;
        void OnMouseBtnPress(int mouseX, int mouseY, int button, int mods) override;
        void OnMouseBtnRelease(int mouseX, int mouseY, int button, int mods) override;
        void OnMouseScroll(int mouseX, int mouseY, int offsetX, int offsetY) override;
        void OnWindowResize(int width, int height) override;
   

    protected:
        glm::mat3 modelMatrix;
        float maxDistance, health, scaleFactor;
        double radians, radiansAux;
        bool shoot, gameOver, firstBullet;
        GameObjectRectangle glont, mapTerrain, conturViata, baraViata, obstacolOriginal;
        GameObjectCircle corp, conturCorp, manaStanga, conturManaStanga, manaDreapta, conturManaDreapta;
        GameObjectCircle corpInamic1, ochiStangInamic1, ochiDreptInamic1;
        vector<GameObjectRectangle> obstacles;
        vector<Enemy> enemies;
        int score = 0;
        
        

    };
}   
