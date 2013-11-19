// Generated by CoffeeScript 1.6.3
(function() {
  var PORT, app, conns, dbs, dotenv, express, rowServer;

  express = require('express');

  app = express();

  app.use(express.logger());

  app.use(express["static"](__dirname + '/public'));

  dotenv = require('dotenv');

  dotenv.load();

  PORT = process.env["PORT"] || 3000;

  dbs = require('./src/js/server_loader.js');

  conns = dbs.connections;

  rowServer = function(response) {
    return function(error, result) {
      var body;
      body = JSON.stringify(result);
      response.setHeader('Content-Length', body.length);
      return response.end(body);
    };
  };

  app.get('/db', function(req, res) {
    var body, conn, name;
    body = {
      servers: []
    };
    for (name in conns) {
      conn = conns[name];
      body.servers.push({
        name: name,
        url: "/db/" + name
      });
    }
    body = JSON.stringify(body);
    res.setHeader('Content-Length', body.length);
    res.setHeader('content-Type', 'application/json');
    return res.end(body);
  });

  app.get('/db/:dbName', function(req, res) {
    var conn;
    conn = conns[req.params.dbName];
    res.setHeader('content-Type', 'application/json');
    return dbs.fetchRows(conn, rowServer(res));
  });

  app.listen(PORT);

  console.log("Listening on port " + PORT);

}).call(this);
