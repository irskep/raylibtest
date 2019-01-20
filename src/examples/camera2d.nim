import raynim

let MAX_BUILDINGS = 100

proc run*() =
    let screenWidth: cint = 800
    let screenHeight: cint = 450

    InitWindow(screenWidth, screenHeight, "raylib [core] example - 2d camera")
    
    var player = newRectangle(400, 280, 40, 40)
    var buildings = newSeq[Rectangle](MAX_BUILDINGS)
    var buildingColors = newSeq[Color](MAX_BUILDINGS)
    var spacing: cfloat = 0

    for i in countup(0, MAX_BUILDINGS - 1):
        buildings[i].width = GetRandomFloat(50, 200)
        buildings[i].height = GetRandomFloat(100, 800)
        buildings[i].y = cfloat(screenHeight) - 130 - buildings[i].height
        buildings[i].x = -6000 + spacing;

        spacing += buildings[i].width;
        
        buildingColors[i] = newColor(GetRandomValue(200, 240), GetRandomValue(200, 240), GetRandomValue(200, 250), 255)

    var camera: Camera2D
    camera.target = newVector2(player.x + 20, player.y + 20)
    camera.offset = newVector2(0, 0)
    camera.rotation = 0
    camera.zoom = 1

    SetTargetFPS(60)

    while not WindowShouldClose():
        if IsKeyDown((cint)KEY_RIGHT):
            player.x += 2               # Player movement
            camera.offset.x -= 2        # Camera displacement with player movement
        elif IsKeyDown((cint)KEY_LEFT):
            player.x -= 2               # Player movement
            camera.offset.x += 2        # Camera displacement with player movement
        
        # Camera target follows player
        camera.target = newVector2(player.x + 20, player.y + 20)
        
        # Camera rotation controls
        if IsKeyDown((cint)KEY_A): camera.rotation -= 1
        elif IsKeyDown((cint)KEY_S): camera.rotation += 1
        
        # Limit camera rotation to 80 degrees (-40 to 40)
        if camera.rotation > 40: camera.rotation = 40
        elif camera.rotation < -40: camera.rotation = -40
        
        # Camera zoom controls
        camera.zoom += cfloat(GetMouseWheelMove()) * 0.05
        
        if camera.zoom > 3.0: camera.zoom = 3.0
        elif camera.zoom < 0.1: camera.zoom = 0.1
        
        # Camera reset (zoom and rotation)
        if IsKeyPressed((cint)KEY_R):
            camera.zoom = 1.0f
            camera.rotation = 0.0f

        BeginDrawing()

        ClearBackground(RAYWHITE)

        BeginMode2D(camera)

        DrawRectangle(-6000, 320, 13000, 8000, DARKGRAY)

        for i in countup(0, MAX_BUILDINGS - 1):
            DrawRectangleRec(buildings[i], buildingColors[i])

        DrawRectangleRec(player, RED)

        DrawRectangle(cint(camera.target.x), -500, 1, screenHeight*4, GREEN)
        DrawRectangle(-500, cint(camera.target.y), screenWidth*4, 1, GREEN)

        EndMode2D()

        DrawText("SCREEN AREA", 640, 10, 20, RED)

        DrawRectangle(0, 0, screenWidth, 5, RED)
        DrawRectangle(0, 5, 5, screenHeight - 10, RED)
        DrawRectangle(screenWidth - 5, 5, 5, screenHeight - 10, RED)
        DrawRectangle(0, screenHeight - 5, screenWidth, 5, RED)

        DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5))
        DrawRectangleLines( 10, 10, 250, 113, BLUE)

        DrawText("Free 2d camera controls:", 20, 20, 10, BLACK)
        DrawText("- Right/Left to move Offset", 40, 40, 10, DARKGRAY)
        DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY)
        DrawText("- A / S to Rotate", 40, 80, 10, DARKGRAY)
        DrawText("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY)

        EndDrawing()

    CloseWindow();        # Close window and OpenGL context