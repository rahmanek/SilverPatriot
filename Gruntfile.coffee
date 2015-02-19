
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
				]

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.registerTask 'default', ['coffee']