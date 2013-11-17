express = require('express')
app     = express()

dbs   = require('../src/js/server_loader.js')
conns = dbs.connections

rowServer = (response) ->
  (error, result) ->
    body = JSON.stringify(result)
    response.setHeader 'Content-Length', body.length
    response.end body

app.get('/',
  (req, res) ->
    conn = conns[0]
    res.setHeader 'content-Type', 'application/json'
    dbs.fetchRows(conn, rowServer(res))
  )

app.listen(3000)
console.log('Listening on port 3000')
