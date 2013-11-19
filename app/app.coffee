express = require('express')
app     = express()

app.use(express.logger())
app.use(express.static(__dirname + '/public'))

dotenv  = require('dotenv')
dotenv.load()

PORT    = process.env["PORT"] || 3000

dbs   = require('./src/js/server_loader.js')
conns = dbs.connections

rowServer = (response) ->
  (error, result) ->
    body = JSON.stringify(result)
    response.setHeader 'Content-Length', body.length
    response.end body

app.get('/db'
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

app.listen(PORT)
console.log("Listening on port #{PORT}")
