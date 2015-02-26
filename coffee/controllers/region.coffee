
module.exports = (app) ->

	app.Express.get '/region', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")
		app.db.Region.findAll
			where:
				regionId: req.query.regionId
				
		.complete (err,record) ->

			app.db.RegionDetail.find
				where:
					regionId: req.query.regionId

			.complete (errDescription,recordDescription) ->
				if !!err or !!errDescription then directive: 'Error - ' + err + errDescription
				else if record.length == 0 then directive = "No Results"
				else directive = "Affirmative"

				res.send
					directive: directive 
					description: recordDescription
					results: record

