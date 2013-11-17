// Generated by CoffeeScript 1.6.3
(function() {
  var anyDB, connectToServer, connections, dotenv, dump, server, serverList, _i, _len;

  anyDB = require('any-db-postgres');

  serverList = require('../../config/servers.json').servers;

  dotenv = require('dotenv');

  dotenv.load();

  dump = function(error, result) {
    return console.log(result.rows);
  };

  connectToServer = function(serverName, callback) {
    var conn, dbURL;
    if (callback == null) {
      callback = dump;
    }
    console.log("Connecting to " + serverName);
    dbURL = process.env["" + (serverName.toUpperCase()) + "_URL"];
    return conn = anyDB.createConnection(dbURL);
  };

  connections = {};

  for (_i = 0, _len = serverList.length; _i < _len; _i++) {
    server = serverList[_i];
    connections[server.name] = connectToServer(server.name);
  }

  exports.connections = connections;

  exports.fetchRows = function(conn, callback) {
    var queryString;
    if (callback == null) {
      callback = dump;
    }
    queryString = "SELECT '" + conn.database + "' as SERVER, NOW() as THETIME;";
    console.log("Fetching row from " + conn.database);
    return conn.query(queryString, callback);
  };

}).call(this);
