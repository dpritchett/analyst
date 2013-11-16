serverLoader = require('../src/js/server_loader')

console.log "Testing server connections:"

for server in serverLoader.serverList
  serverLoader.connectToServer(server.name)
