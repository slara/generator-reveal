# Generated on <%= (new Date).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
module.exports = (grunt) ->

    grunt.initConfig

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/*.md'
                    'slides/*.html'
                    'js/*.js'<% if (useSass) { %>
                    'css/*.css'<% } %>
                ]

            index:
                files: [
                    'index.tpl'
                    'slides/list.json'
                ]
                tasks: ['build:index']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']
        <% if (useSass) { %>
            sass:
                files: ['css/source/theme.scss']
                tasks: ['sass']

        sass:

            theme:
                files:
                    'css/theme.css': 'css/source/theme.scss'
        <% } %>
        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

        coffeelint:

            options:
                indentation:
                    value: 4

            all: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:

            dist:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                        'bower_components/**'
                        'js/**'<% if (useSass) { %>
                        'css/*.css'<% } %>
                    ]
                    dest: 'dist/'
                },{
                    expand: true
                    src: ['index.html']
                    dest: 'dist/'
                    filter: 'isFile'
                }]


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

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'server',
        'Run presentation locally and start watch process (living document).', [
            'build:index'<% if (useSass) { %>
            'sass'<% } %>
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'test'<% if (useSass) { %>
            'sass'<% } %>
            'build:index'
            'copy'
        ]

    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'server'
    ]
