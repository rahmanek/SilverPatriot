
module.exports = (app) ->
	app.Express.get '/provider', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		res.send "Provider Info"