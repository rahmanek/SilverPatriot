module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'RegionData',
		regionId:Sequelize.STRING
		calendarYear:Sequelize.INTEGER
		description: Sequelize.STRING
		value: Sequelize.DECIMAL
