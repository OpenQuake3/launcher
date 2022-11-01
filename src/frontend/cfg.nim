#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import os ; export os
import ./deps
#................................
# Config
#................................
# General
const shortname * = "kua"
# Window
const wRes      * = Vector2(x:16, y:9)
const wScale    * = 10.0
const wName     * = "Kua: Launcher"
# Process
const waitTimer * = 10



# TODO: Move to json based, instead of hardcoded
#........................................
# Folders
#..........
template getRootDir()     :string=  getAppDir()/".."
template getLauncherDir() :string=  getRootDir()/"launcher"
template getCacheDir()    :string=  getLauncherDir()/"cache"
template getExtractDir()  :string=  getCacheDir()/"tmp"
#..........
# Files
template getLastFile()    :string=  getLauncherDir()/"last.json"
template getHistoryFile() :string=  getLauncherDir()/"history.json"
template getCfgFile()     :string=  getLauncherDir()/"cfg.json"
template getEngineFile()  :string=  
  when defined windows: getRootDir() / &"{shortname}-x64.exe"
  else:                 getRootDir() / &"{shortname}.x64"
#........................................


#........................................
# Folders
let rootDir    * = getRootDir()
let appDir     * = getLauncherDir()
let cacheDir   * = getCacheDir()
let extractDir * = getExtractDir()
# Files
let cfgFile    * = getCfgFile()
let lastFile   * = getLastFile()
let histFile   * = getHistoryFile()
let engineFile * = getEngineFile()
#..........
# Repository
const repoUser * = "heysokam"
const repoName * = shortname
#........................................


#..........
let chkList * = @[
  ## List of files that will flag as firstRun if one of them is missing
  lastFile, 
  engineFile,
  ]
#..........

