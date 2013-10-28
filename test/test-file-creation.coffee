path = require 'path'
helpers = require('yeoman-generator').test

describe 'Generator Reveal', ->
    # SUT object.
    app = {}

    beforeEach (done) ->
        helpers.testDirectory path.join(__dirname, 'temp'), (err) ->
            return done(err) if err

            app = helpers.createGenerator 'reveal:app', [
                '../../app'
            ]
            app.options['skip-install'] = true

            # May have to wait for app.config to be written
            # to file system as saving is debounced by 5 milliseconds.
            # Not waiting here, may result in
            # ERROR with `rm -rf` of testDirectory.
            setTimeout done, 10

    it 'should generate dotfiles', (done) ->
        expected = [
            '.bowerrc'
            '.editorconfig'
            '.gitignore'
            '.jshintrc'
            '.yo-rc.json'
        ]

        helpers.mockPrompt app, {}
        app.options['skip-install'] = true
        app.run {}, ->
            helpers.assertFiles expected
            done()

    it 'generates expected boilerplate files', (done) ->
        expected = [
            'Gruntfile.coffee'
            'templates/_index.html'
            'templates/_section.html'
            'slides/list.json'
            'slides/index.md'
            'bower.json'
            'js/loadhtmlslides.js'
            'package.json'
        ]

        helpers.mockPrompt app, {}

        app.run {}, ->
            helpers.assertFiles expected
            done()

    it 'generates package.json with correct version', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'package.json test'
            packageVersion: '1.2.3'

        app.run {}, ->
            helpers.assertFile 'package.json', /"version": "1.2.3"/
            done()

    it 'uses defaults for .yo-rc.json config', (done) ->
        # Skip user input, since we
        # really want to check the defaults.
        app.askFor = ->

        app.run {}, ->
            # Wait for config to be written.
            setTimeout ->
                helpers.assertFile '.yo-rc.json', /"generator-reveal"/
                helpers.assertFile '.yo-rc.json', /"useSass": false/
                helpers.assertFile '.yo-rc.json', /"presentationTitle": "Reveal.js and Yeoman is Awesomeness"/
                helpers.assertFile '.yo-rc.json', /"packageVersion": "0.0.0"/
                done()
            , 10

    it 'updates .yo-rc.json config according to prompt input', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'ICanHazConfig'
            packageVersion: '0.1.0'
            useSass: true

        app.run {}, ->
            # Wait for config to be written.
            setTimeout ->
                helpers.assertFile '.yo-rc.json', /"generator-reveal"/
                helpers.assertFile '.yo-rc.json', /"useSass": true/
                helpers.assertFile '.yo-rc.json', /"presentationTitle": "ICanHazConfig"/
                helpers.assertFile '.yo-rc.json', /"packageVersion": "0.1.0"/
                done()
            , 10

    it 'generates SASS support for themes', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'SASS Support 4 Custom Themes'
            packageVersion: '0.0.1'
            useSass: true

        app.run {}, ->
            helpers.assertFile 'css/source/theme.scss', /@import "..\/..\/bower_components\/reveal.js\/css\/theme\/template\/theme";/
            helpers.assertFile 'Gruntfile.coffee', /sass:/
            helpers.assertFile 'Gruntfile.coffee', /'css\/\*.css'/
            helpers.assertFile 'Gruntfile.coffee', /'css\/theme.css': 'css\/source\/theme.scss'/
            helpers.assertFile 'templates/_index.html', /<link rel="stylesheet" href="css\/theme.css" id="theme">/
            helpers.assertFile 'package.json', /"grunt-contrib-sass"/
            done()

    describe 'Sub-Generator Slide', ->
        slide = {}

        beforeEach (done) ->
            helpers.mockPrompt app, {}
            done()

        it 'creates html slide', ->
            slide = helpers.createGenerator 'reveal:slide', [
                '../../slide'
            ], ['default']

            app.run {}, ->
                slide.run [], ->
                    helpers.assertFile 'slides/default.html',
                        /<h2>default<\/h2>/
                    helpers.assertFile 'slides/list.json',
                            /"default.html"/

        describe '--attributes option', ->
            it 'creates html slide with attributes hash in list.json', ->
                slide = helpers.createGenerator 'reveal:slide', [
                    '../../slide'
                ], ['html-attributes']
                slide.options.attributes = true

                app.run {}, ->
                slide.run [], ->
                    helpers.assertFile 'slides/html-attributes.html',
                        /<h2>html-attributes<\/h2>/
                    helpers.assertFile 'slides/list.json',
                        /"filename": "html-attributes.html",/
                    helpers.assertFile 'slides/list.json',
                        /"attr": {/
                    helpers.assertFile 'slides/list.json',
                        /"data-background": "#ff0000"/

        describe '--notes option', ->
            it 'creates html slide with notes', ->
                slide = helpers.createGenerator 'reveal:slide', [
                    '../../slide'
                ], ['html-notes']
                slide.options.notes = true

                app.run {}, ->
                    slide.run [], ->
                        helpers.assertFile 'slides/html-notes.html',
                            /<aside class="notes">/
                        helpers.assertFile 'slides/list.json',
                            /"html-notes.html"/

            describe 'together with --markdown', ->
                it 'creates markdown slide with notes', ->
                    slide = helpers.createGenerator 'reveal:slide', [
                        '../../slide'
                    ], ['markdown-notes']
                    slide.options.notes = true
                    slide.options.markdown = true

                    app.run {}, ->
                    slide.run [], ->
                        helpers.assertFile 'slides/markdown-notes.md',
                            /note:/
                        helpers.assertFile 'slides/list.json',
                            /"markdown-notes.md"/

        describe '--markdown option', ->
            it 'creates markdown slide', ->
                slide = helpers.createGenerator 'reveal:slide', [
                    '../../slide'
                ], ['markdown']
                slide.options.markdown = true

                app.run {}, ->
                    slide.run {}, ->
                        helpers.assertFile 'slides/markdown.md',
                            /##  markdown/
                        helpers.assertFile 'slides/list.json',
                            /"markdown.md"/

            describe 'together with --attributes', ->
                it 'creates markdown slide with attributes hash in list.json', ->
                    slide = helpers.createGenerator 'reveal:slide', [
                        '../../slide'
                    ], ['markdown-attributes']
                    slide.options.attributes = true
                    slide.options.markdown = true

                    app.run {}, ->
                    slide.run [], ->
                        helpers.assertFile 'slides/markdown-attributes.md',
                            /##  markdown/
                        helpers.assertFile 'slides/list.json',
                            /"filename": "markdown-attributes.md",/
                        helpers.assertFile 'slides/list.json',
                            /"attr": {/
                        helpers.assertFile 'slides/list.json',
                            /"data-background": "#ff0000"/
