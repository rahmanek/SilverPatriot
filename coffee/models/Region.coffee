module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'Region',
		name: Sequelize.STRING
		regionId: Sequelize.STRING
		stat1: Sequelize.STRING
