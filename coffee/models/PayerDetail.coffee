module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'PayerDetail',
		payerId:Sequelize.STRING
		shortName:Sequelize.STRING
		longName:Sequelize.STRING