#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import osproc
import strformat
#......................
from ./tools import toBool
#......................


#......................
proc err*(msg :string; code :int=1)= echo msg; quit(code)
#......................
proc launchQuit*(bin, dir :string; code :int= 0) :void=
  discard bin.startProcess(dir, options = {poParentStreams})
  quit(code)
proc launch(bin, dir :string) :int=
  let p :Process= bin.startProcess(dir, options = {poParentStreams})
  result = p.waitForExit
  p.close
#......................
type Exit = enum
  Ok     = 0,
  Error  = 1,
  Update = 2,
  Todo   = 4,
converter toInt(code :Exit) :int= code.ord
#......................
proc run*(bin, dir :string) :void=
  var code :int
  code = bin.launch(dir)
  if   code and Exit.Ok:      return
  elif code and Exit.Error:   err(&"Couldn't launch {bin}.")
  elif code and Exit.Update:  code = bin.launch(dir)
#......................
