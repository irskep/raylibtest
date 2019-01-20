import "../../raylib-nim/src/raylib"

proc newVector2*(x: cfloat, y: cfloat): Vector2 =
  result.x = x
  result.y = y

proc newVector3*(x: cfloat, y: cfloat, z: cfloat): Vector3 =
  result.x = x
  result.y = y
  result.z = z

proc newCamera3D*(`type`: CameraType, fovy: cfloat): Camera3D =
  result.fovy = fovy
  result.`type` = (cint) `type`
  result.up = newVector3(0, 1, 0)

proc newColor*(r: uint8, g: uint8, b: uint8, a: uint8): Color =
  result.r = r
  result.g = g
  result.b = b
  result.a = a