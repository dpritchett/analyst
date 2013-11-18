dbs = require('../src/js/server_loader')

console.log "Testing server connections:"

for name, conn of dbs.connections
  callback = (conn) ->
    (err, res) ->
      console.log(res)
      conn.end()

  dbs.fetchRows(conn, callback(conn))
