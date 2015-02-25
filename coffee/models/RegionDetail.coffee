module.exports = (sequelize, Sequelize) ->
	return sequelize.define 'RegionDetail',
		regionId: Sequelize.STRING
		shortName: Sequelize.STRING
		longName: Sequelize.STRING
