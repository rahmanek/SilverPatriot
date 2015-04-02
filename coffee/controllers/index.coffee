
module.exports = (app) ->
	require('./region.js')(app)
	require('./service.js')(app)
	require('./provider.js')(app)