module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'Payer',
		payerId: Sequelize.STRING
		name: Sequelize.STRING
		lng: Sequelize.DECIMAL