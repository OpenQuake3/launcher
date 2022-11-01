#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import ./deps
#................................
import ../core/procc
#................................
import ./cfg
#................................
import ./state  as app
import ./input  as i
import ./window as w
#................................


#................................
proc getStateText(st :State) :string=
  case st
  of State.None:        result = ""
  of State.ChkDownload: result = "Checking for a new Release"
  of State.Download:    result = "Downloading latest version"
  of State.Update:      result = "Updating local version"
  of State.Launch:      result = "Launching the game"
#................................


#................................
# Core
#................................
proc start*()=
  w.init()

#................................
proc close() :bool= windowShouldClose() or wExit

proc frame*() :void=
  i.update()
  w.update()
  beginDrawing()
  # drawFPS(10,10)

  clearBackground(Darkgray);
  let margin = 5.cfloat
  let wbox   = Rectangle( x:margin, y:margin*2, width: wWidth.cfloat-margin*2, height: wHeight.cfloat - margin*3 )
  # wExit    = windowBox(wbox, (&"#198# {wName}").cstring)
  groupBox(wbox, (&"{wName}").cstring)
  # let text = textFormat("Mouse Position: [ %.0f, %.0f ]  Offset: [ %.3f, %.3f]", app.mousePos.x, app.mousePos.y, app.panOffset.x, app.panOffset.y)
  let text   = app.state.getStateText
  let textY  = (app.wHeight/2).int - margin.int #40
  let textX  = margin.int * 2  #10
  drawText(text.cstring, textX, textY, 10, White)

  endDrawing()
  clearBackground(Blank)
#................................
template frame*(sec :int) :void=  sec.wait; frame()

#................................
proc loop*()=
  while not close():
    frame()

#................................
proc stop*()= discard
#................................





import ../core/tools
import ../core/rlsops
import ../core/rlsmodel
#........................................


proc extractLatest*() :string=
  let last = gitGetReleaseLast(cfg.repoUser, cfg.repoName)
  let file = last.dlFile(0, cacheDir)
  file.unzip(extractDir)
  return extractDir
#........................................


#....................
# Checks
#..........
proc isLatest*(jfile, user, repo :string) :bool=
  if not jfile.fileExists: return false
  let local = jfile.readRelease.id              # Get local id
  let last  = gitGetReleaseLast(user, repo).id  # Get web id
  echo "Local: ",local," Last: ",last
  result    = local == last                     # Return comparison
#..........
proc firstRun*() :bool=
  result = false
  for file in chkList:
    if not fileExists file: return true
#..........
proc shouldUpdate*() :bool= 
  not cfg.lastFile.isLatest(cfg.repoUser, cfg.repoName)
#..........
proc install*(src :string) :void=  cp src, cfg.rootDir
#........................................


#................................
proc shouldDownload*() :bool= 
  app.state = State.ChkDownload
  frame()
  if firstRun(): 
    lastFile.writeReleaseLast(cfg.repoUser, cfg.repoName)
    return true
  if shouldUpdate():
    return true
  else: return false
#...................
proc runDownload*() :string=
  app.state = State.Download
  waitTimer.frame()
  return cfg.lastFile.readRelease.dlFile(0, cacheDir)
#................................
proc runUpdate*() :void=
  var zip :string
  if shouldDownload():
    zip = runDownload()
  # Update
  if not zip.fileExists:
    err("Couldn't find update zip file. Exiting.")
  app.state = State.Update
  waitTimer.frame()
  zip.unzip(cfg.extractDir)
  cfg.extractDir.install()
#................................
proc shouldLaunch*() :bool= 
  if cfg.engineFile.fileExists: return true
  result = false
  echo &"Engine file does not exist: {cfg.engineFile}"
#..................
proc runLaunch*() :void=
  app.state = State.Launch
  waitTimer.frame()
  engineFile.launchQuit(rootDir)
