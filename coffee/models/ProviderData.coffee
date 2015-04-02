module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ProviderData',
		providerId:Sequelize.STRING
		calendarYear:Sequelize.INTEGER
		description: Sequelize.STRING
		value: Sequelize.DECIMAL
