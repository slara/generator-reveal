path = require 'path'
helpers = require('yeoman-generator').test

describe 'Generator Reveal', ->
    app = {}

    beforeEach (done) ->
        helpers.testDirectory path.join(__dirname, 'temp'), (err) ->
            return done(err) if err

            app = helpers.createGenerator 'reveal:app', [
                '../../app'
            ]
            app.options['skip-install'] = true

            done()

    it 'should generate dotfiles', (done) ->
        expected = [
            '.bowerrc'
            '.editorconfig'
            '.gitignore'
            '.jshintrc'
        ]

        helpers.mockPrompt app, {}
        app.options['skip-install'] = true
        app.run {}, ->
            helpers.assertFiles expected
            done()

    it 'generates expected boilerplate files', (done) ->
        expected = [
            'Gruntfile.coffee'
            'index.tpl'
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
            presentationTitle: 'package.json test',
            packageVersion: '1.2.3'

        app.run {}, ->
            helpers.assertFile 'package.json', /"version": "1.2.3"/
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
                            /notes:/
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
