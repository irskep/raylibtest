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

while window_should_close() == 0:

  update(unsafeAddr camera)

  if key_down((cint) 'Z') == 1:
    camera.target = newVector3(0, 0, 0)

  begin_drawing()

  clear_background(WHITE)

  #[
    HERE IS THE PROBLEM INE

    C declaration:
      RLAPI void BeginMode3D(Camera3D camera); // Initializes 3D mode with custom camera (3D)

    Nim binding declaration:
      https://github.com/Skrylar/raylib-nim/blob/master/src/raylibimpl/raylib_raylib.nim#L677
      proc begin_mode3D*(camera: Camera3D)

    Compiler error:

      Error: execution of an external compiler program 'clang -c  -w  -I/Users/steve/.choosenim/toolchains/nim-0.19.2/lib -I/Users/steve/_d/scratch/raylibtests/./binaries -o /Users/steve/.cache/nim/demo_d/demo.c.o /Users/steve/.cache/nim/demo_d/demo.c' failedwith exit code: 1

      /Users/steve/.cache/nim/demo_d/demo.c:210:16: error: passing 'Camera3D *' (aka 'struct Camera3D *') to parameter of incompatible type 'Camera3D' (aka 'struct Camera3D'); dereference with *
                              BeginMode3D((&camera_YdOSHnfVGOQpp9aCewApXpA));
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                          *
      /Users/steve/_d/scratch/raylibtests/./binaries/raylib.h:872:33: note: passing argument to parameter 'camera' here
      RLAPI void BeginMode3D(Camera3D camera);                          // Initializes 3D mode with custom camera (3D)
                                      ^
      1 error generated.
  ]#
  camera.begin_mode3D()

  draw_cube(cubePosition, 2, 2, 2, RED)
  draw_cube_wires(cubePosition, 2, 2, 2, MAROON)

  draw_grid(10, 1)
  end_mode3d()

  end_drawing()

close_window()