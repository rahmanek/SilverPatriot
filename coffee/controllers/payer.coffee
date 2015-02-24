
module.exports = (app) ->
	app.Express.get '/payer', (req, res) -> 
		res.header("Access-Control-Allow-Origin", "*")

		if req.param.payerId?
			app.db.Region.find
				where:
					regionCode: req.param('payerId')
			.complete (err,record) ->
				if !!err
					console.log('Search Failure', err)
				else if !records
					console.log 'Failure'
					res.send 'fail'
				else
					res.send record
		else
			res.send "General Info"