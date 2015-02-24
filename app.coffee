express = require('express')
http = require('http')
bodyParser = require('body-parser')
Express = express()

Express.use bodyParser.urlencoded
	extended: true
Express.set 'port', process.env.PORT || 3000

database = require('./js/models/index.js') false, (db) ->

	app = 
		db: db
		Express: Express

	Express.get '/', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")
		res.send "Root"

	routes = require('./js/controllers/index.js')(app)

	http.createServer(Express).listen Express.get('port'), () -> 
		console.log "Express server listening on port " + Express.get 'port'