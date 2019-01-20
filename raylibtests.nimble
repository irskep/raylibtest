# Package

version       = "0.1.0"
author        = "Steve Landey"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["binaries/raylib_test"]


# Dependencies

requires "nim >= 0.19.2", "https://github.com/irskep/nim-glfw#raw-cdecls"
