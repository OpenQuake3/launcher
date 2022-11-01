#...................................................................
#: Kua: Launcher : Copyright (C) 2022 sOkam! : GNU GPLv3 or higher :
#...................................................................

import std/options  # For keys that sometimes will be missing

type GitUser * = object
  login               *:string
  id                  *:int
  node_id             *:string
  avatar_url          *:string
  gravatar_id         *:string
  url                 *:string
  html_url            *:string
  followers_url       *:string
  following_url       *:string
  gists_url           *:string
  starred_url         *:string
  subscriptions_url   *:string
  organizations_url   *:string
  repos_url           *:string
  events_url          *:string
  received_events_url *:string
  `type`              *:string
  site_admin          *:bool

type Asset * = object
  url                  *:string
  id                   *:int
  node_id              *:string
  name                 *:string
  label                *:Option[string]
  uploader             *:GitUser
  content_type         *:string
  state                *:string
  size                 *:int
  download_count       *:int
  created_at           *:string
  updated_at           *:string
  browser_download_url *:string

type Release * = object
  url              *:string
  assets_url       *:string
  upload_url       *:string
  html_url         *:string
  id               *:int
  author           *:GitUser
  node_id          *:string
  tag_name         *:string
  target_commitish *:string
  name             *:string
  draft            *:bool
  prerelease       *:bool
  created_at       *:string
  published_at     *:string
  assets           *:seq[Asset]
  tarball_url      *:string
  zipball_url      *:string
  body             *:string

type ReleaseList * = seq[Release]
