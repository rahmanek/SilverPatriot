
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

		if req.query.year? and queryStatus
			app.db.ServiceDetail.findAll
				where: detailQuery

			.then (serviceDetail) ->
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
					.then (payments) ->

						app.db.ServiceData.aggregate "value", "sum",
							where:
								serviceCode: serviceArray
								year: req.query.year
								description: "Top 3 Payer Claims"

						.then (claims) ->
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
				results = {}
				semaphore = 0
				resolve = () ->
					if semaphore == 0
						send "Affirmative", results
				extractCategoryList = (level, catName) ->
					nextLevelStr = "cat" + (level + 1)
					if level == 4 then nextLevelStr = "serviceCode"

					whereQuery = " WHERE cat" + level + "='" + catName + "'"
					if level == 0 then whereQuery = ""

					buildQuery = "SELECT DISTINCT \"" + nextLevelStr + "\"" +
						" FROM \"ServiceDetails\"" +
						whereQuery

					app.db.sequelize.query buildQuery
					.then (queryResults) ->						
						catList = []
						for result in queryResults
							catList.push result[nextLevelStr]

						results[nextLevelStr] = catList
						semaphore--
						if semaphore == 0 then resolve()
						
				if req.query.baseCat
					semaphore++
					extractCategoryList 0, null				
				if req.query.cat1?
					semaphore++
					extractCategoryList 1, req.query.cat1
				if req.query.cat2?
					semaphore++
					extractCategoryList 2, req.query.cat2
				if req.query.cat3?
					semaphore++
					extractCategoryList 3, req.query.cat3
				if req.query.cat4?
					semaphore++
					extractCategoryList 4, req.query.cat4

		else send 'Invalid Query', []