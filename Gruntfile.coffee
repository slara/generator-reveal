module.exports = (grunt) ->

    grunt.initConfig

        watch:

            coffee:
                files: ['*.coffee', 'test/*.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['*.js', '*/*.js']
                tasks: ['jshint', 'mochaTest']

        coffeelint:

            options:
                indentation:
                    value: 4
            all:
                src: ['*.coffee', 'test/*.coffee']

        jshint:
            options:
                jshintrc: '.jshintrc'

            all:
                src: ['*.js', '*/*.js']

        mochaTest:
            options:
                require: 'coffee-script'
            all:
                src: ['test/*.coffee']

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
