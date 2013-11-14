dotenv = require('dotenv')
dotenv.load()

anyDB = require('any-db-postgres')
dbURL = process.env.DATABASE_URL

conn  = anyDB.createConnection(dbURL)  # Takes an optional callback

sql   = 'SELECT * FROM spree_users LIMIT 1;'

conn.query(sql).on('row', (row) ->
  console.log(row.email)
  conn.end())
