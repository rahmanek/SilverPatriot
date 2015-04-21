module.exports = (app) ->

	app.Express.get '/', (req, res) ->
		res.header("Access-Control-Allow-Origin", "*")

		buildQuery = "SELECT DISTINCT cohort 
			FROM \"ProviderDetails\""

		app.db.sequelize.query buildQuery
		.then (queryResults) ->
			res.send queryResults