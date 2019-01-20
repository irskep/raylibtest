import dynlib
import "../raylib-nim/src/raylib"
import src/raylib_utils

# Attempts to port various raylib examples to Nim.
# Currently: https://github.com/raysan5/raylib/blob/master/examples/core/core_3d_camera_free.c

let screenSize = newVector2(800, 450)

init_window((cint) screenSize.x, (cint) screenSize.y, "Hello world")
set_target_fps(60)

var camera: Camera3D# = newCamera3D(CAMERA_PERSPECTIVE, 45)
camera.`type` = (cint) CAMERA_PERSPECTIVE
camera.position = newVector3(10, 10, 10)
camera.target = newVector3(0, 0, 0)
camera.up = newVector3(0, 1, 0)
camera.fovy = 45
camera.mode=((cint)CAMERA_FREE)

let cubePosition = newVector3(0, 0, 0)

while window_should_close() == 0:

  (addr camera).update()

  if key_down((cint) 'Z') == 1:
    camera.target = newVector3(0, 0, 0)

  begin_drawing()

  clear_background(WHITE)

  camera.begin_mode3D()

  draw_cube(cubePosition, 2, 2, 2, RED)
  draw_cube_wires(cubePosition, 2, 2, 2, MAROON)

  draw_grid(10, 1)
  end_mode3d()

  draw_fps(10, 10)
  draw_text("Welcome to the third dimension!", 10, 40, 20, DARKGRAY)

  end_drawing()

close_window()