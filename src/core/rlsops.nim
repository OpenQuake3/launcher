#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import ./tools
#........................................
# Releases Data
#........................................
import ./rlsmodel
import jsony
# Data downloading
import std/httpclient
import std/strformat
#..........
proc gitGetReleaseData*(user, repo :string) :string=
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Accept": "application/vnd.github+json" })
  result = $client.get(&"https://api.github.com/repos/{user}/{repo}/releases").body
#..........
proc gitGetReleaseDataLast*(user, repo :string) :string=
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "Accept": "application/vnd.github+json" })
  result = $client.get(&"https://api.github.com/repos/{user}/{repo}/releases/latest").body
#..........
import std/os
proc dlFile*(rls :Release; assetId :int; trg :string) :string=
  let startDir = getCurrentDir()
  let url      = rls.assets[assetId].browser_download_url
  let name     = rls.assets[assetId].name
  if not trg.dirExists: md trg
  trg.setCurrentDir
  url.dlFile(rls.assets[assetId].name)
  startDir.setCurrentDir
  result = trg/name

#....................
# Data Reading
#..........
import std/json
#..........
proc pretty*(list :ReleaseList) :string= list.toJson.fromJson.pretty
proc pretty*(rls  :Release)     :string=  rls.toJson.fromJson.pretty
#..........
# With download
template gitGetReleaseList*(user, repo :string) :ReleaseList=  gitGetReleaseData(user,repo).fromJson(ReleaseList)
template gitGetReleaseLast*(user, repo :string) :Release=      gitGetReleaseDataLast(user,repo).fromJson(Release)
#..........
# From local
template readReleaseList*(jfile :string) :ReleaseList=  jfile.readFile.fromJson(ReleaseList)
template readReleaseLast*(jfile :string) :Release=      jfile.readFile.fromJson(ReleaseList)[0]
template readRelease*(jfile :string)     :Release=      jfile.readFile.fromJson(Release)
#....................

#....................
# Data writing
#..........
# With download
proc writeReleaseList*(file, user, repo :string)=  file.writeFile(gitGetReleaseList(user, repo).pretty)
proc writeReleaseLast*(file, user, repo :string)=  file.writeFile(gitGetReleaseLast(user, repo).pretty)
#..........
# From memory
template write*(file :string; list :ReleaseList)=  file.writeFile(list.pretty)
template write*(file :string;  rls :Release)=      file.writeFile( rls.pretty)
template write*(file, data :string)=               file.writeFile(data.fromJson.pretty)
#..........
template append*(file :string; rls :Release)=      file.append(data.fromJson.pretty)
#..........
