
module.exports = (app) ->

	app.Express.get '/service', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		send = (directive, results) ->
			res.send
				directive: directive
				results: results

		if !req.query.serviceCode?
			send("Invalid Parameters", {})
		else
			app.db.ServiceDetail.find
				where:
					code: req.query.serviceCode
			
			.complete (err,serviceDetail) ->
				if !serviceDetail?
					send("Invalid Service Code", {})
				else
					app.db.BetosDetail.find
						where:
							code: serviceDetail.betosCode

					.complete (err2, betosDetail) ->
						if !betosDetail?
							send("Database Record Missing", {})
						else
							app.db.ServiceData.findAll
								where:
									code: req.query.serviceCode
							.complete (err3, serviceData) ->
								if !!err or !!err2 or !!err3 then directive: 'Error - ' + err + err2 + err3
								else if serviceData.length == 0 then directive = "No Results"
								else directive = "Affirmative"

								results = 
									detail:
										service:serviceDetail
										betos: betosDetail
									data: serviceData

								send(directive, results)
