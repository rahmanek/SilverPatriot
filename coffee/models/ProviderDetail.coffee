module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'ProviderDetail',
		orgId:Sequelize.STRING
		facId:Sequelize.STRING
		hospitalName:Sequelize.STRING
		cohort:Sequelize.STRING
		address:Sequelize.STRING
		city:Sequelize.STRING
		zip:Sequelize.STRING
		region:Sequelize.STRING
		taxStatus:Sequelize.STRING
		system:Sequelize.STRING
		hospitalProfLinker:Sequelize.STRING
