import sequtils

import src/glfw
import "../raylib-nim/src/raylib"

import src/raylib_utils

let screenSize = newVector2(800, 450)

set_config_flags(cuchar(FLAG_VSYNC_HINT))

init_window((cint) screenSize.x, (cint) screenSize.y, "Hello world")
set_target_fps(60)

let videoMode: VideoMode = getPrimaryMonitor().videoMode()

var camera: Camera3D# = newCamera3D(CAMERA_PERSPECTIVE, 45)
camera.`type` = (cint) CAMERA_PERSPECTIVE
camera.position = newVector3(4, 2, 4)
camera.target = newVector3(0, 1.8, 0)
camera.up = newVector3(0, 1, 0)
camera.fovy = 60
camera.mode = CAMERA_FIRST_PERSON

var twenty = newSeq[int](20)
for i in countup(0, 19):
  twenty[i] = i
let heights = map(twenty, proc(i: int): cfloat =
  cfloat(get_random_value(1, 12)))
let positions = map(twenty, proc(i: int): Vector3 =
  newVector3(
    cfloat(get_random_value(-15, 15)),
    heights[i] / 2,
    cfloat(get_random_value(-15, 15))))
let colors = map(twenty, proc(i: int): Color =
  newColor(uint8(get_random_value(20, 255)), uint8(get_random_value(10, 55)), 30, 255))

var wentFS = false
let sw = screen_width()
let sh = screen_height()

while window_should_close() == 0:

  (addr camera).update()

  if key_down(cint('Z')) == 1 and not wentFS:
    wentFS = true
    set_window_size(videoMode.size.w, videoMode.size.h)
    toggle_fullscreen()

  begin_drawing()

  clear_background(RAYWHITE)

  camera.begin_mode3D()

  draw_plane(newVector3(0, 0, 0), newVector2(32, 32), LIGHTGRAY)

  draw_cube(newVector3(-16, 2.5, 0), 1, 5, 32, BLUE)
  draw_cube(newVector3(16, 2.5, 0), 1, 5, 32, LIME)
  draw_cube(newVector3(0, 2.5, 16), 32, 5, 1, GOLD)

  for i in twenty:
    draw_cube(positions[i], 2, heights[i], 2, colors[i])
    draw_cube_wires(positions[i], 2, heights[i], 2, MAROON)

  # draw_grid(10, 1)
  end_mode3d()

  draw_fps(10, 10)
  draw_text("Welcome to the third dimension!", 10, 40, 20, DARKGRAY)

  end_drawing()

close_window()