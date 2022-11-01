#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import ./deps
import ./state as app

#................................
proc chkDrag()=
  if isMouseButtonPressed(MouseButton.Left):
    let box = Rectangle(x:0, y:0, width: app.wWidth, height:20)
    if checkCollisionPointRec(app.mousePos, box):
      app.wDrag     = true
      app.panOffset = mousePos

#................................
proc update*()=
  chkDrag()
  app.mousePos = getMousePosition()
