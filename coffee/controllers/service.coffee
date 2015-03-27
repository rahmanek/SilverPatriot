
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

		if !req.query.year? or !queryStatus then send 'Invalid Query', [] 
		else
			app.db.ServiceDetail.findAll
				where: detailQuery

			.complete (err1, serviceDetail) ->
				serviceArray = []

				for service in serviceDetail
					serviceArray.push service.serviceCode
				app.db.ServiceData.findAll
					where:
						serviceCode: serviceArray
						year: req.query.year
				.complete (err2, serviceData) ->
					if !!err1 or !!err2 then send('Error - ' + err1 + err2, {}) 
					else if serviceData.length == 0 then send("No Data", {})
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

						data = []
						serviceDescriptions = ["Top 3 Payer Payments","Top 3 Payer Claims"]
						for description in serviceDescriptions
							value=0
							for datum in serviceData
								if datum.description == description
									value += Number(datum.value)
							data.push
								value:value
								year: req.query.year
								description:description
								
						results=
							data: data
							detail: detail

						sequelize.query("SELECT * FROM 'ServiceDetails'",{ type: sequelize.QueryTypes.SELECT})
						.then (details) ->
							console.log details

						send 'Affirmative', results