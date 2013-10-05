module.exports = (grunt) ->

    grunt.initConfig

        watch:

            gruntfile:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['*.js', '*/*.js']
                tasks: ['jshint', 'mochaTest']

        coffeelint:

            options:
                indentation:
                    value: 4
            gruntfile:
                src: ['Gruntfile.coffee']

        jshint:
            options:
                jshintrc: '.jshintrc'

            all:
                src: ['*.js', '*/*.js']

        mochaTest:

            all:
                src: ['test/*.js']

        clean:

            test:
                src: ['test/temp']


    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    # Define default task.
    grunt.registerTask 'default', [
        'coffeelint',
        'jshint',
        'clean',
        'mochaTest'
    ]
