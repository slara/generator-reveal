# Generated on <%= (new Date).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
module.exports = (grunt) ->

    # Configuration.
    yeomanConfig =
        livereloadPort: 35729 # Recommended standard.

    grunt.initConfig

        watch:

            options:
                spawn: false

            livereload:
                options:
                    livereload: yeomanConfig.livereloadPort
                files: [
                    'index.html',
                    'slides/*.md',
                    'slides/*.html',
                    'js/*.js'
                ]

            index:
                files: [
                    'index.tpl',
                    'slides/list.json'
                ]
                tasks: ['build:index']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: require('path').resolve('.')
                    open: true
                    middleware: (connect, options) ->
                        [
                            # Add livereload middleware.
                            require('connect-livereload')(
                                port: yeomanConfig.livereloadPort
                            ),
                            connect.static(options.base)
                        ]

        coffeelint:

            options:
                indentation:
                    value: 4

            files: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            files: ['js/*.js']

    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'build:index',
        'Build index.html from index.tpl and slides/list.json.',
        ->
            template = grunt.file.read 'index.tpl'
            slides = grunt.file.readJSON 'slides/list.json'
            html = grunt.template.process template, data:
                slides:
                    slides
            grunt.file.write 'index.html', html

    grunt.registerTask 'server',
        'Run presentation locally and start watch process (living document).', [
            'build:index',
            'connect:livereload',
            'watch'
        ]

    # Define default task.
    grunt.registerTask 'default', [
        'coffeelint',
        'jshint',
        'build:index',
        'connect:livereload',
        'watch'
    ]
