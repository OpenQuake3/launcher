#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import ./cfg
import ./deps
import ./state as app

#................................
proc init*()=
  setConfigFlags(WindowUndecorated);
  initWindow(wWidth.cint, wHeight.cint, wName)
  # setWindowPosition(wPos.x.cint, wPos.y.cint)

import strformat
proc drag()=
  var diff = app.mousePos - app.panOffset
  app.wPos += diff;
  if isMouseButtonReleased(MouseButton.Left): app.wDrag = false
  setWindowPosition(app.wPos.x.cint, app.wPos.y.cint);
  echo &" wPos x:{app.wPos.x} y:{app.wPos.y.cint} | mPos x:{app.mousePos.x} y:{app.mousePos.y} | Offs x:{app.panOffset.x} y:{app.panOffset.y} | Diff x:{diff.x} y:{diff.y}"

#................................
proc update*()=
  app.wPos = getWindowPosition()
  # if app.wDrag: drag()
