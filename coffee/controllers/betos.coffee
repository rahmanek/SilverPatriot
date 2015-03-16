
module.exports = (app) ->

	app.Express.get '/betos', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		send = (directive, results) ->
			res.send
				directive: directive
				results: results

		if !req.query.betosCode? then send("Invalid Parameters", {})
		else
			app.db.BetosDetail.find
				where:
					code: req.query.betosCode
			
			.complete (err,betosDetail) ->
				if !betosDetail? then send("Invalid Betos Code", {})
				else
					app.db.ServiceDetail.findAll
						where:
							betosCode: req.query.betosCode
					.complete (err2, betosServiceCodes) ->
						if !betosServiceCodes? then send("Database Error", {})
						else
							codeList = []
							for code in betosServiceCodes 
								codeList.push code.code
							app.db.ServiceData.findAll
								where:
									code: codeList
							.complete (err3, serviceData) ->
								betosData = []
								payments12 = 0
								claims12 = 0
								payments11 = 0
								claims11 = 0
								serviceDescriptions = ["Top 3 Payer Payments","Top 3 Payer Claims"]
								serviceYears = [2011,2012]
								for year in serviceYears
									for description in serviceDescriptions
										value=0

										for datum in serviceData
											if datum.description == description and datum.year == year
												value += Number(datum.value)
										betosData.push
											value:value
											year:year
											description:description


								results = 
									detail: betosDetail
									data: betosData

								if !!err or !!err2 or !!err3 then directive: 'Error - ' + err + err2 + err3
								else directive = "Affirmative"
								send(directive, results)

