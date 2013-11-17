anyDB      = require('any-db-postgres')
serverList = require('../../config/servers.json').servers
dotenv     = require('dotenv')

dotenv.load()

dump = (error, result) ->
  console.log result.rows

connectToServer = (serverName, callback=dump) ->
  dbURL = process.env["#{serverName.toUpperCase()}_URL"]
  conn  = anyDB.createConnection(dbURL)  # Takes an optional callback

connections = {}

for server in serverList
  connections[server.name] = connectToServer(server.name)

exports.connections = connections

exports.fetchRows = (conn, callback=dump) ->
  queryString ||= "SELECT '#{conn.database}' as SERVER, NOW() as THETIME;"

  conn.query(queryString, callback)
