import sequtils

import "../glfw"
import "../raylib"

proc run*() =
  let screenSize = newVector2(800, 450)

  SetConfigFlags(cuchar(FLAG_VSYNC_HINT))

  InitWindow((cint) screenSize.x, (cint) screenSize.y, "Hello world")
  SetTargetFPS(60)

  # bonus functionality: read screen size from glfw so we can fullscreen nicely
  let videoMode: VideoMode = getPrimaryMonitor().videoMode()

  var camera: Camera3D# = newCamera3D(CAMERA_PERSPECTIVE, 45)
  camera.`type` = (cint) CAMERA_PERSPECTIVE
  camera.position = newVector3(4, 2, 4)
  camera.target = newVector3(0, 1.8, 0)
  camera.up = newVector3(0, 1, 0)
  camera.fovy = 60
  SetCameraMode(camera, (cint) CAMERA_FIRST_PERSON)

  var twenty = newSeq[int](20)
  for i in countup(0, 19):
    twenty[i] = i

  let heights = map(twenty, proc(i: int): cfloat = GetRandomFloat(1, 12))

  let positions = map(twenty, proc(i: int): Vector3 =
    newVector3(
      GetRandomFloat(-15, 15),
      heights[i] / 2,
      GetRandomFloat(-15, 15)))

  let colors = map(twenty, proc(i: int): Color =
    newColor(GetRandomValue(20, 255), GetRandomValue(10, 55), 30, 255))

  var wentFS = false
  let sw = GetScreenWidth()
  let sh = GetScreenHeight()

  while not WindowShouldClose():

    UpdateCamera(addr camera)

    if IsKeyDown(cint('Z')) and not wentFS:
      wentFS = true
      SetWindowSize(videoMode.size.w, videoMode.size.h)
      ToggleFullscreen()

    BeginDrawing()

    ClearBackground(RAYWHITE)

    camera.BeginMode3D()

    DrawPlane(newVector3(0, 0, 0), newVector2(32, 32), LIGHTGRAY)

    DrawCube(newVector3(-16, 2.5, 0), 1, 5, 32, BLUE)
    DrawCube(newVector3(16, 2.5, 0), 1, 5, 32, LIME)
    DrawCube(newVector3(0, 2.5, 16), 32, 5, 1, GOLD)

    for i in twenty:
      DrawCube(positions[i], 2, heights[i], 2, colors[i])
      DrawCubeWires(positions[i], 2, heights[i], 2, MAROON)

    # draw_grid(10, 1)
    EndMode3D()

    DrawFPS(10, 10)
    DrawText("Welcome to the third dimension!", 10, 40, 20, DARKGRAY)

    EndDrawing()

  CloseWindow()