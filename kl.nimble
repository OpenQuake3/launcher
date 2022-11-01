#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import os
#......................
version         = "0.0.1" #a
author          = "sOkam!"
description     = "Kua: Launcher"
license         = "GPL3 or higher"
#......................
let shortname   = "klauncher"
let runDir      = "launcher"
let backend     = rundir/"backend"
let frontend    = rundir/"frontend"
let srcBackend  = "backend"
let srcFrontend = "frontend"

#......................
# Dependencies
requires "nim   >= 1.6.8" # Set to current 2022 version, without explicit needs for this version
requires "nimraylib_now"  # Mainly for RayGui
requires "jsony"          # For parsing the json data downloaded from git releases RestAPI page
requires "zip"            # For unzipping the release files

#......................
# Folder config
srcDir = "src"
binDir = "bin"

#......................
# Binaries
#namedBin[src] = trg  # Compiles src.nim from srcDir as "trg"
namedBin[shortname]   = shortname
namedBin[srcBackend]  = backend
namedBin[srcFrontend] = frontend

#......................
template infoBuild() :void=
  echo shortname,": Building ",description," | v",version
template infoDone() :void=
  echo shortname,": Done building."
template infoTarget(trg :string) :void=
  echo shortname,": Starting build for ",trg,"."

#......................
before build: infoBuild()
after  build: infoDone() 
#......................
before win:   infoTarget("windows")
task win, "Builds package for windows with mingw":
  exec "nimble build -d:mingw -d:release -d:win"
#......................
before lnx:   infoTarget("linux")
task lnx, "Builds package for linux natively":
  exec "nimble build -d:gcc -d:release -d:lnx"
#......................
before dist:   infoTarget("windows and linux")
task dist, "Builds both windows and linux versions":
  lnxTask()
  winTask()
