rowFetcher = require('../src/js/server_loader')

console.log "Testing row fetcher"

for server in serverLoader.serverList
  serverLoader.connectToServer(server.name)
