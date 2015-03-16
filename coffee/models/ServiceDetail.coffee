module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ServiceDetail',
		code: Sequelize.STRING
		betosCode: Sequelize.STRING
		terminationDate: Sequelize.STRING
		description: Sequelize.TEXT
		hspiTracking: Sequelize.BOOLEAN