
module.exports = (app) ->
	require('./payer.js')(app)
	require('./region.js')(app)