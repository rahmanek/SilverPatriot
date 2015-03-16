module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ServiceData',
		code: Sequelize.STRING
		year: Sequelize.INTEGER
		description: Sequelize.STRING
		value: Sequelize.DECIMAL