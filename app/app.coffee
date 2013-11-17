express = require('express')
app     = express()

dbs   = require('../src/js/server_loader.js')
conns = dbs.connections

rowServer = (response) ->
  (error, result) ->
    body = JSON.stringify(result)
    response.setHeader 'Content-Length', body.length
    response.end body

app.get('/'
  (req, res) ->
    body =
      servers: []

    for name, conn of conns
      body.servers.push(
        name: name,
        url:  "/db/#{name}"
      )

    body = JSON.stringify(body)

    res.setHeader 'Content-Length', body.length
    res.setHeader 'content-Type', 'application/json'
    res.end body
  )


app.get('/db/:dbName',
  (req, res) ->
    conn = conns[req.params.dbName]
    res.setHeader 'content-Type', 'application/json'
    dbs.fetchRows(conn, rowServer(res))
  )

app.listen(3000)
console.log('Listening on port 3000')
