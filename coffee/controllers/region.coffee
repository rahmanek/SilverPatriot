
module.exports = (app) ->

	app.Express.get '/region', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		app.db.Region.findAll
			where:
				regionId: req.query.regionId
				
		.complete (err,record) ->

			if !!err then directive: 'Error - ' + err
			else if record.length == 0 then directive = "No Results"
			else directive = "Affirmative"

			res.send
				directive: directive
				results: record
