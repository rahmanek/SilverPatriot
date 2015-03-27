module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ServiceData',
		serviceCode: Sequelize.STRING
		year: Sequelize.INTEGER
		description: Sequelize.STRING
		value: Sequelize.DECIMAL