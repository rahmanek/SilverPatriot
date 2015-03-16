
module.exports = (app) ->

	app.Express.get '/region', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")
		app.db.RegionData.findAll
			where:
				regionId: req.query.regionId
				
		.complete (err,records) ->

			app.db.RegionDetail.find
				where:
					regionId: req.query.regionId

			.complete (err2,records2) ->
				if !!err or !!err2 then directive: 'Error - ' + err + err2
				else if records.length == 0 then directive = "No Results"
				else directive = "Affirmative"

				res.send
					directive: directive
					detail: records2
					results: records