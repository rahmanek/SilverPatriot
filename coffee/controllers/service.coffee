
module.exports = (app) ->


	app.Express.get '/service', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		send = (directive, results) ->
			res.send
				directive: directive
				results: results

		detailQuery = {}
		queryStatus = true
		catLevel = 0
		if req.query.serviceCode?
			detailQuery.serviceCode = req.query.serviceCode
			catLevel = 5
		else if req.query.cat4?
			detailQuery.cat4 = req.query.cat4
			catLevel = 4
		else if req.query.cat3?
			detailQuery.cat3 = req.query.cat3
			catLevel = 3
		else if req.query.cat2?
			detailQuery.cat2 = req.query.cat2
			catLevel = 2
		else if req.query.cat1?
			detailQuery.cat1 = req.query.cat1
			catLevel = 1
		else queryStatus = false

		console.log req.query.year? + queryStatus

		if req.query.year? and queryStatus
			app.db.ServiceDetail.findAll
				where: detailQuery

			.complete (err1, serviceDetail) ->
				if serviceDetail.length == 0 then send("No Data", {})
				else
					serviceArray = []

					for service in serviceDetail
						serviceArray.push service.serviceCode

					app.db.ServiceData.aggregate "value", "sum",
						where:
							serviceCode: serviceArray
							year: req.query.year
							description: "Top 3 Payer Payments"
					.complete (err2, payments) ->

						app.db.ServiceData.aggregate "value", "sum",
							where:
								serviceCode: serviceArray
								year: req.query.year
								description: "Top 3 Payer Claims"

						.complete (err3, claims) ->

							if !!err1 or !!err2 or !!err3 then send('Error - ' + err1 + err2 + err3, {}) 
							else
								detail = {}
								detail.codeCount = serviceDetail.length
								detail.catLevel = catLevel
								if catLevel >= 1
									detail.cat1 = serviceDetail[0].cat1
									detail.label = serviceDetail[0].cat1
								if catLevel >= 2
									detail.cat2 = serviceDetail[0].cat2
									detail.label = serviceDetail[0].cat2
								if catLevel >= 3
									detail.cat3 = serviceDetail[0].cat3
									detail.label = serviceDetail[0].cat3
								if catLevel >= 4
									detail.cat4 = serviceDetail[0].cat4
									detail.label = serviceDetail[0].cat4
									detail.betosCode = serviceDetail[0].betosCode
								if catLevel == 5
									detail.description = serviceDetail[0].description
									detail.label = serviceDetail[0].serviceCode
										
								results=
									data: [
										year: req.query.year
										value: claims
										description: "Top 3 Payer Claims"
									,
										year: req.query.year
										value: payments
										description: "Top 3 Payer Payments"
									]
									detail: detail

								send 'Affirmative', results
		else if req.query.catMap?
			app.db.ServiceDetail.findAll()
			.complete (err1, serviceDetailAll) ->
				results = []
				for detail in serviceDetailAll
					results.push
						serviceCode: detail.serviceCode
						betosCode:detail.betosCode
						cat1:detail.cat1
						cat2:detail.cat2
						cat3:detail.cat3
						cat4:detail.cat4
				send 'Affirmative', results
		else send 'Invalid Query', []