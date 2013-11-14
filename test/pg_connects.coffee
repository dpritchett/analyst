dotenv = require('dotenv')
dotenv.load()

anyDB = require('any-db-postgres')
dbURL = process.env.DATABASE_URL

conn  = anyDB.createConnection(dbURL)  # Takes an optional callback

sql   = 'SELECT NOW() as THETIME;'

conn.query(sql).on('row', (row) ->
  console.log(row)
  conn.end())
