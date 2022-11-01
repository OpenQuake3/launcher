import std/httpclient
var client = newHttpClient()
# echo client.getContent("http://google.com")

#................................................
import std/[asyncdispatch]

proc onProgressChanged(total, progress, speed: BiggestInt) {.async.} =
  echo("Downloaded ", progress, " of ", total)
  echo("Current rate: ", speed div 1000, "kb/s")

proc asyncProc*() {.async.} =
  var client = newAsyncHttpClient()
  client.onProgressChanged = onProgressChanged
  discard await client.getContent("http://speedtest-ams2.digitalocean.com/100mb.test")

# waitFor asyncProc()
#................................................


import strformat
#................................................
client.headers = newHttpHeaders({ "Accept": "application/vnd.github+json" })
let jsonBody = $client.get("https://api.github.com/repos/heysokam/osdf/releases").body

const jsonFile = "test.json"
jsonFile.writeFile(jsonBody)

import ./model
import jsony
proc renameHook*(v: var ReleaseList, fieldName: var string) =
  if fieldName == "type": fieldName = "typ"
let rls = jsonFile.readFile.fromJson(ReleaseList)
echo rls[0].url
# echo rls[0].author.typ
echo rls[0].body
echo rls[0].author.login



