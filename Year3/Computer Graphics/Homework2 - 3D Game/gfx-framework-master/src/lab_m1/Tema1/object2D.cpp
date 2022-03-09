#include "object2D.h"

#include <vector>

#include "core/engine.h"
#include "utils/gl_utils.h"


Mesh* object2D::CreateSquare(
    const std::string& name,
    glm::vec3 leftBottomCorner,
    float length,
    glm::vec3 color,
    bool fill)
{
    glm::vec3 corner = leftBottomCorner;

    std::vector<VertexFormat> vertices =
    {
        VertexFormat(corner, color),
        VertexFormat(corner + glm::vec3(length, 0, 0), color),
        VertexFormat(corner + glm::vec3(length, length, 0), color),
        VertexFormat(corner + glm::vec3(0, length, 0), color)
    };

    Mesh* square = new Mesh(name);
    std::vector<unsigned int> indices = { 0, 1, 2, 3 };

    if (!fill) {
        square->SetDrawMode(GL_LINE_LOOP);
    }
    else {
        // Draw 2 triangles. Add the remaining 2 indices
        indices.push_back(0);
        indices.push_back(2);
    }

    square->InitFromData(vertices, indices);
    return square;
}

Mesh* object2D::CreateCircle(glm::vec3 color, std::string name, float radius, glm::vec3 center)
{
    // drawing the circular area
    Mesh* circle = new Mesh(name);

    std::vector<VertexFormat> vertices;
    std::vector<unsigned int > indices;

    vertices.emplace_back(center, color);
    for (unsigned short i = 0; i < 72; i++)
    {
        double arg = 2 * M_PI * i / 72;

        vertices.emplace_back(glm::vec3(center.x + radius * cos(arg), center.y + radius * sin(arg), 0), color);
        indices.push_back(i);
    }
    indices.push_back(72);
    indices.push_back(1);

    circle->InitFromData(vertices, indices);
    circle->SetDrawMode(GL_TRIANGLE_FAN);
    return circle;
}


Mesh* object2D::CreateRectangle(
    const std::string& name,
    glm::vec3 centerOfRectangle,
    float width,
    float height,
    glm::vec3 color,
    bool fill)
{
    glm::vec3 center = centerOfRectangle;

    std::vector<VertexFormat> vertices =
    {
        VertexFormat(center + glm::vec3(- (width/2), -(height/2), 0), color),
        VertexFormat(center + glm::vec3(width/2, -(height/2), 0), color),
        VertexFormat(center + glm::vec3(width/2, height/2, 0), color),
        VertexFormat(center + glm::vec3(-(width/2), height/2, 0), color)
    };

    Mesh* rectangle = new Mesh(name);
    std::vector<unsigned int> indices = { 0, 1, 2, 3 };

    if (!fill) {
        rectangle->SetDrawMode(GL_LINE_LOOP);
    }
    else {
        // Draw 2 triangles. Add the remaining 2 indices
        indices.push_back(0);
        indices.push_back(2);
    }

    rectangle->InitFromData(vertices, indices);
    return rectangle;
}


Mesh* object2D::CreateRectangleKnowingLeftCorner(
    const std::string& name,
    glm::vec3 leftBottomCorner,
    float width,
    float height,
    glm::vec3 color,
    bool fill)
{

    std::vector<VertexFormat> vertices =
    {
        VertexFormat(leftBottomCorner, color),
        VertexFormat(leftBottomCorner + glm::vec3(width, 0, 0), color),
        VertexFormat(leftBottomCorner + glm::vec3(width, height, 0), color),
        VertexFormat(leftBottomCorner + glm::vec3(0, height, 0), color)
    };

    Mesh* rectangle = new Mesh(name);
    std::vector<unsigned int> indices = { 0, 1, 2, 3 };

    if (!fill) {
        rectangle->SetDrawMode(GL_LINE_LOOP);
    }
    else {
        // Draw 2 triangles. Add the remaining 2 indices
        indices.push_back(0);
        indices.push_back(2);
    }

    rectangle->InitFromData(vertices, indices);
    return rectangle;
}