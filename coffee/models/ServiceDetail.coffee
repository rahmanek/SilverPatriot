module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ServiceDetail',
		serviceCode: Sequelize.STRING
		betosCode: Sequelize.STRING
		terminationDate: Sequelize.STRING
		description: Sequelize.TEXT
		hspiTracking: Sequelize.BOOLEAN
		cat1:Sequelize.STRING
		cat2:Sequelize.STRING
		cat3:Sequelize.STRING
		cat4:Sequelize.STRING