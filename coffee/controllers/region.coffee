
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
					
			.complete (err,records) ->

				app.db.RegionDetail.find
					where:
						regionId: req.query.regionId

				.complete (err2,records2) ->
					if !!err or !!err2 then directive: 'Error - ' + err + err2
					else if records.length == 0 then directive = "No Results"
					else directive = "Affirmative"

					results =
						data: records
						detail: records2

					send(directive, results)

		else if req.query.description?
			app.db.RegionData.findAll
				where:
					description: req.query.description
			.complete (err,records) ->
				app.db.RegionDetail.findAll()
				.complete (err2,records2) ->
					if !!err or !!err2 then directive: 'Error - ' + err + err2
					else if records.length == 0 then directive = "No Results"
					else directive = "Affirmative"
					results = 
						data: records
						detail: records2
					send(directive, results)