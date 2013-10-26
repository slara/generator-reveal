module.exports = (grunt) ->

    grunt.initConfig

        watch:

            coffee:
                files: ['{,*/}*.coffee']
                tasks: ['coffeelint', 'coffee', 'mochaTest']
            jshint:
                files: ['app/{,*/}*.js']
                tasks: ['jshint', 'mochaTest']

        coffeelint:

            options:
                grunt.file.readJSON('.coffeelintrc')
            all:
                src: ['{,*/}*.coffee']

        coffee:

            compile:
                expand: true
                src: ['app/index.coffee', 'slide/index.coffee']
                ext: '.js'

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

    # Test task run by CI.
    grunt.registerTask 'test', [
        'coffee'
        'coffeelint'
        'jshint'
        'clean'
        'mochaTest'
        'clean'
    ]

    # Default task to get development going.
    grunt.registerTask 'default', [
        'test'
        'watch'
    ]
