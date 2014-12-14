'use strict'

{spawn} = require 'child_process'

module.exports = (grunt) ->
    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.initConfig
        watch:
            coffee:
                files: ['{,*/}*.coffee']
                tasks: ['coffee', 'test']

        coffee:
            compile:
                expand: true
                src: ['app/index.coffee', 'slide/index.coffee']
                ext: '.js'

    grunt.registerTask 'test', 'Run `npm test`', ->
        done = @async()
        test = spawn 'npm', ['test'], stdio: 'inherit'
        test.on 'close', done

    # Default task to get development going.
    grunt.registerTask 'default', [
        'coffee'
        'test'
        'watch'
    ]
