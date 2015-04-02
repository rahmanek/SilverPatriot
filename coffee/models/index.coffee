
module.exports = (clean,callback) ->
	Sequelize = require('sequelize')
	postgres = require('pg')

	if process.env.appEnvironment == 'production'
		match = process.env.HEROKU_POSTGRESQL_GRAY_URL.match /postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/

		sequelize = new Sequelize match[5], match[1], match[2],
			dialect: 'postgres'
			protocol: 'postgres'
			port: match[4]
			host: match[3]
			logging: true

	else
		dbInfo = JSON.parse process.env.pgDb
		sequelize = new Sequelize 'patriot', dbInfo.dbUser, dbInfo.dbPass,
			dialect: 'postgres',
			port: dbInfo.dbPort

		db =
			ServiceDetail: require("./ServiceDetail.js")(sequelize,Sequelize)
			ServiceData: require("./ServiceData.js")(sequelize,Sequelize)
			RegionData: require("./RegionData.js")(sequelize,Sequelize)
			RegionDetail: require("./RegionDetail.js")(sequelize,Sequelize)
			ProviderData: require("./ProviderData.js")(sequelize,Sequelize)
			ProviderDetail: require("./ProviderDetail.js")(sequelize,Sequelize)
			sequeilze:sequelize
			Sequelize:Sequelize
			
	sequelize.sync
		force: clean
	.complete (err) ->
		if !!err
			console.log 'Database Failed to Authenticate'
		else
			callback db
