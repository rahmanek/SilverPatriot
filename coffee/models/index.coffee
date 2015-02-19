
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

		console.log "Heroku Database"
	else
		dbInfo = JSON.parse process.env.patriotDb
		sequelize = new Sequelize dbInfo.dbName, dbInfo.dbUser, dbInfo.dbPass,
			dialect: 'postgres',
			port: dbInfo.dbPort


		Region = require("./Region.js")(sequelize,Sequelize)
		Payer = require("./Payer.js")(sequelize,Sequelize)

		sequelize.sync
			force: clean
		.complete (err) ->
			if !!err
				console.log 'Database Failed to Authenticate'
			else
				db =
					Region: Region
					Payer: Payer
				callback db
