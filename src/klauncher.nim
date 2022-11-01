#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import os
#......................
import ./core/procc
#......................


#......................
let root = getAppDir()
let dir  = root/"launcher"

#......................
when defined win:
  let frontend = dir/"frontend.exe"
  let backend  = dir/"backend.exe"
else:
  let frontend = dir/"frontend"
  let backend  = dir/"backend"

#......................
proc run()=
  backend.run(dir)
  frontend.run(dir)
#......................
when isMainModule: run()
