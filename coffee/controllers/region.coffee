
module.exports = (app) ->

	app.Express.get '/region', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		send = (directive, results) ->
			res.send
				directive: directive
				results: results

		if req.query.regionId?
			app.db.RegionData.findAll
				where:
					regionId: req.query.regionId
					
			.then (records) ->

				app.db.RegionDetail.find
					where:
						regionId: req.query.regionId

				.then (records2) ->
					if records.length == 0 then directive = "No Results"
					else directive = "Affirmative"

					results =
						data: records
						detail: records2

					send(directive, results)

		else if req.query.description?
			app.db.RegionData.findAll
				where:
					description: req.query.description
			.then (records) ->
				app.db.RegionDetail.findAll()
				.then (records2) ->
					if records.length == 0 then directive = "No Results"
					else directive = "Affirmative"
					results = 
						data: records
						detail: records2
					send(directive, results)