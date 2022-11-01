#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................


import ../backend/core

proc run()=
  let first = firstRun()
  if first:
    md cacheDir
    md extractDir
  if first or update():
    let tmp  = extractLatest()
    let test = rootDir/"test"
    md test
    tmp.install(test)
    lastFile.writeReleaseLast(cfg.repoUser, cfg.repoName)
  else: echo "Game: Up to date"
