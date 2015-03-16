
module.exports = (app) ->
	require('./payer.js')(app)
	require('./region.js')(app)
	require('./service.js')(app)
	require('./betos.js')(app)