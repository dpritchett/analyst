dbs = require('../src/js/server_loader')

console.log "Testing server connections:"

for name, conn of dbs.connections
  dbs.fetchRows(conn)
