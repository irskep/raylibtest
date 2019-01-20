import nimterop/cImport

#[
  "so when calling the proc, the va_list parameter would be - cast[va_list](param)" -@zacharycarter

  more random varargs sample code:
  https://github.com/judofyr/bob/blob/20c6dcbf59ae41410256bdf81e1a4362d423df47/bobpreload.nim#L175-L200
]#
type va_list* {.importc, bycopy, header:"<stdarg.h>".} = object

cDebug()
cIncludeDir("$projpath")
cAddSearchDir("$projpath/src")
cImport(cSearchPath("raylib.h"))