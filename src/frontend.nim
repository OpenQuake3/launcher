#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import ./frontend/cfg  as cfg
import ./frontend/core as app
import ./core/tools

#......................
proc run()=
  echo "test frontend"
  app.start()

  # TODO: Fix this ugly mess, just to avoid using async
  if app.shouldUpdate(): app.runUpdate()
  if app.shouldLaunch(): app.runLaunch()

  app.stop()
#......................
when isMainModule: run()
