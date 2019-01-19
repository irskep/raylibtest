import dynlib
import raylib

init_window(800, 450, "Hello world")
set_target_fps(60)
while window_should_close() == 0:
  begin_drawing()
  clear_background(WHITE)
  draw_text("It works!", 190, 200, 20, LIGHTGRAY)
  end_drawing()

close_window()