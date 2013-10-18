module.exports = (grunt) ->

    grunt.initConfig

        watch:

            coffee:
                files: ['{,*/}*.coffee']
                tasks: ['coffeelint', 'mochaTest']
            jshint:
                files: ['app/{,*/}*.js']
                tasks: ['jshint', 'mochaTest']

        coffeelint:

            options:
                grunt.file.readJSON('.coffeelintrc')
            all:
                src: ['{,*/}*.coffee']

        jshint:

            options:
                jshintrc: 'app/templates/jshintrc'
            all:
                src: ['app/templates/*.js']

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
        'mochaTest',
        'clean'
    ]
