import prologue
import norm/[sqlite, model]
import ../snorlogue
import std/[strutils, options, strformat, logging]
from os import `putEnv`

putEnv("DB_HOST", "db.sqlite3")
addHandler(newConsoleLogger(levelThreshold = lvlDebug))

type User* = ref object of Model
  name*: string

type Item* = ref object of Model
  name*: string
  owner*: User

withDb:
  db.createTables(User())
  db.createTables(Item())

proc `$`*(model: User): string = model.name

proc `$`*(model: Item): string = model.name & " owned by " & $model.owner


proc main() =
  var app: Prologue = newApp()
  app.addCrudRoutes(User)
  app.addCrudRoutes(Item)
  app.addAdminRoutes()
  app.run()

main()
