proc main() {.importc: "main".}

var
  sidata {.importc: "_sidata".}: cint
  sdata {.importc: "_sdata".}: cint
  edata {.importc: "_edata".}: cint
  sbss {.importc: "_sbss".}: cint
  ebss {.importc: "_ebss".}: cint

proc Reset_Handler() {.exportc.} =
  var offset {.volatile.} = 0
  while cast[int](sdata.addr) + offset * sizeof(int) < cast[int](edata.addr):
    cast[ptr int](cast[pointer](cast[int](sdata.addr) + offset * sizeof(int)))[] = cast[ptr int](cast[pointer](cast[int](sidata.addr) + offset * sizeof(int)))[]
    offset.inc

  offset = 0
  while cast[int](sbss.addr) + offset * sizeof(int) < cast[int](ebss.addr):
    cast[ptr int](cast[pointer](cast[int](sbss.addr) + offset * sizeof(int) ))[] = 0
    offset.inc

  main()
  while true:
    discard

