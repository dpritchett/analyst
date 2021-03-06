anyDB      = require('any-db-postgres')
dotenv     = require('dotenv')
dotenv.load()

ENV_NAME   = process.env["NODE_ENV"]
serverList = require('../../config/servers.json')[ENV_NAME]


dump = (error, result) ->
  console.log result.rows

connectToServer = (serverName, callback=dump) ->
  console.log "Connecting to #{serverName}"
  dbURL = process.env["#{serverName.toUpperCase()}_URL"]
  conn  = anyDB.createConnection(dbURL)  # Takes an optional callback

connections = {}

for server in serverList
  connections[server.name] = connectToServer(server.name)

exports.connections = connections

exports.fetchRows = (conn, callback=dump) ->
  queryString = "SELECT '#{conn.database}' as SERVER, NOW() as THETIME;"
  console.log "Fetching row from #{conn.database}"

  conn.query(queryString, callback)
