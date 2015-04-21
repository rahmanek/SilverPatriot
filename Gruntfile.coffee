
module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			compile:
				files: [
					expand: true
					cwd: 'coffee/',
					src: '**/*.coffee'
					dest: 'js/'
					flatten: false
					ext: '.js'
				,
					expand: true
					src: 'app.coffee'
					ext: '.js'
				,
					'dbLoader/app.js':'dbLoader/app.coffee'
				]

		watch:
			files: ["coffee/**/*.coffee", "app.coffee"]
			tasks: "default"

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.registerTask 'default', ['coffee', 'watch']