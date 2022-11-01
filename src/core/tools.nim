#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import std/httpclient
#........................................
template dlFile*(url, file :string) :void=
  let client = newHttpClient()
  client.downloadFile(url, name)
#........................................
import zip/zipfiles
#..........
proc unzip*(file, trgDir :string) :void=
  var zip :ZipArchive
  var ok = zip.open(file) 
  if not ok:
    echo "Opening ",file," failed"
    return
  zip.extractAll(trgDir)
#........................................
import std/os
#..........
proc md*(dir :string) :void=
  if not dir.dirExists: dir.createDir
#........................................
proc rm*(dir :string) :void=
  if dir.dirExists: dir.removeDir
#........................................
proc cp*(src, trg :string) :void=
  # Get src file objects info
  if not src.dirExists and not src.fileExists: return
  let sinfo = src.getFileInfo(true)
  let srcf  = sinfo.kind == pcFile or sinfo.kind == pcLinkToFile  # src is file or link to file
  let srcd  = sinfo.kind == pcDir  or sinfo.kind == pcLinkToDir   # src is dir  or link to dir
  # Get trg file objects info
  let tinfo = trg.getFileInfo(true)
  let trgf  = tinfo.kind == pcFile or tinfo.kind == pcLinkToFile  # trg is file or link to file
  let trgd  = tinfo.kind == pcDir  or tinfo.kind == pcLinkToDir   # trg is dir  or link to dir 
  # Do the copying
  if   srcf and trgf: copyFile src, trg
  elif srcf and trgd: copyFileToDir src, trg
  elif srcd and trgd: copyDir src, trg
  else: return
#........................................
proc append*(file, data :string)=
  var f :File
  let ok = f.open(file, fmAppend)
  if not ok:
    echo "Opening ",file," failed"
    return
  f.write(file)
#........................................
proc wait*(sec :int) :void= sleep(sec*1000)
#........................................

#......................
converter toBool*(num  :int) :bool=
  result = if num == 0: false else: true
