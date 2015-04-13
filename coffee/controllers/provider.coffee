
module.exports = (app) ->
	app.Express.get '/provider', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		send = (directive, results) ->
			res.send
				directive: directive
				results: results

		if req.query.orgId?
			app.db.ProviderDetail.find
				where:
					orgId: req.query.orgId
			.then (records) ->

				app.db.ProviderData.findAll
					where:
						providerId: req.query.orgId
				.then (records2) ->

					directive = "Affirmative"

					results = 
						data:records2
						detail: records

					send directive, results

		else if req.query.region?
			app.db.ProviderDetail.findAll
				where:
					region: req.query.region
			.then (records) ->
				directive = "Affirmative"

				results = 
					data:[]
					detail: records

				send directive, results
