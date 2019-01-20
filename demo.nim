import dynlib
import raylib
import "src/raylib_utils"

let screenSize = newVector2(800, 450)

init_window((cint) screenSize.x, (cint) screenSize.y, "Hello world")
set_target_fps(60)

var camera: Camera3D = newCamera3D(CAMERA_PERSPECTIVE, 45)
camera.position = newVector3(10, 10, 10)
camera.target = newVector3(0, 0, 0)

let cubePosition = newVector3(0, 0, 0)

# `mode=`(camera, (cint) CAMERA_FREE)

while window_should_close() == 0:

  update(unsafeAddr camera)

  if key_down((cint) 'Z') == 1:
    camera.target = newVector3(0, 0, 0)

  begin_drawing()

  clear_background(WHITE)

  camera.begin_mode3D()

  draw_cube(cubePosition, 2, 2, 2, RED)
  draw_cube_wires(cubePosition, 2, 2, 2, MAROON)

  draw_grid(10, 1)
  end_mode3d()

  end_drawing()

close_window()