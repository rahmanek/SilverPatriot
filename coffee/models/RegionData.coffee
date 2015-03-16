module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'Region',
		regionId:Sequelize.STRING
		calendarYear:Sequelize.INTEGER
		description: Sequelize.STRING
		value: Sequelize.DECIMAL
