module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'Hospital',
		hospitalId:Sequelize.STRING
		longName:Sequelize.STRING
		quartile:Sequelize.DECIMAL