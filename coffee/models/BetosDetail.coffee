module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'BetosDetail',
		code: Sequelize.STRING	
		cat1: Sequelize.STRING
		cat2: Sequelize.STRING
		cat3: Sequelize.STRING
		cat4: Sequelize.STRING