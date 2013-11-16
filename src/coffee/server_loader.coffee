exports.serverList = require('../../config/servers.json').servers

exports.connectToServer = (serverName) ->
  dotenv = require('dotenv')
  dotenv.load()

  anyDB = require('any-db-postgres')
  dbURL = process.env["#{serverName.toUpperCase()}_URL"]

  conn  = anyDB.createConnection(dbURL)  # Takes an optional callback

  sql   = "SELECT '#{serverName}' as SERVER, NOW() as THETIME;"

  conn.query(sql).on('row', (row) ->
    console.log(row)
    conn.end())
