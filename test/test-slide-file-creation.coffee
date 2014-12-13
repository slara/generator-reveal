path = require 'path'
yeoman = require 'yeoman-generator'

assert = yeoman.assert
helpers = yeoman.test

describe 'Sub-Generator Slide', ->
    beforeEach (done) ->
        helpers
            .run(path.join __dirname, '../app')
            .withOptions('skip-install': true)
            .withPrompts(
                presentationTitle: 'Sub-Generator Slide Test'
                packageVersion: '0.0.0-test'
            )
            .on 'end', done

    describe 'default (no options passed)', ->
        it 'creates html slide', (done) ->
            slide = helpers.createGenerator 'reveal:slide', [
                path.join __dirname, '../slide'
            ], ['default']

            slide.run [], ->
                assert.fileContent 'slides/default.html',
                    /<h2>default<\/h2>/
                assert.fileContent 'slides/list.json',
                    /"default.html"/
                done()

    describe '--attributes option', ->
        it 'creates html slide with attributes hash in list.json', (done) ->
            slide = helpers.createGenerator 'reveal:slide', [
                path.join __dirname, '../slide'
            ], ['html-attributes']
            slide.options.attributes = true

            slide.run [], ->
                assert.fileContent 'slides/html-attributes.html',
                    /<h2>html-attributes<\/h2>/
                assert.fileContent 'slides/list.json',
                    /"filename": "html-attributes.html",/
                assert.fileContent 'slides/list.json',
                    /"attr": {/
                assert.fileContent 'slides/list.json',
                    /"data-background": "#ff0000"/
                done()

    describe '--notes option', ->
        it 'creates html slide with notes', (done) ->
            slide = helpers.createGenerator 'reveal:slide', [
                path.join __dirname, '../slide'
            ], ['html-notes']
            slide.options.notes = true

            slide.run [], ->
                assert.fileContent 'slides/html-notes.html',
                    /<aside class="notes">/
                assert.fileContent 'slides/list.json',
                    /"html-notes.html"/
                done()

        describe 'together with --markdown', ->
            it 'creates markdown slide with notes', (done) ->
                slide = helpers.createGenerator 'reveal:slide', [
                    path.join __dirname, '../slide'
                ], ['markdown-notes']
                slide.options.notes = true
                slide.options.markdown = true

                slide.run [], ->
                    assert.fileContent 'slides/markdown-notes.md',
                        /note:/
                    assert.fileContent 'slides/list.json',
                        /"markdown-notes.md"/
                    done()

    describe '--markdown option', ->
        it 'creates markdown slide', (done) ->
            slide = helpers.createGenerator 'reveal:slide', [
                path.join __dirname, '../slide'
            ], ['markdown']
            slide.options.markdown = true

            slide.run {}, ->
                assert.fileContent 'slides/markdown.md',
                    /##  markdown/
                assert.fileContent 'slides/list.json',
                    /"markdown.md"/
                done()

        describe 'together with --attributes', ->
            it 'creates markdown slide with attributes hash in list.json', (done) ->
                slide = helpers.createGenerator 'reveal:slide', [
                    path.join __dirname, '../slide'
                ], ['markdown-attributes']
                slide.options.attributes = true
                slide.options.markdown = true

                slide.run [], ->
                    assert.fileContent 'slides/markdown-attributes.md',
                        /##  markdown/
                    assert.fileContent 'slides/list.json',
                        /"filename": "markdown-attributes.md",/
                    assert.fileContent 'slides/list.json',
                        /"attr": {/
                    assert.fileContent 'slides/list.json',
                        /"data-background": "#ff0000"/
                    done()
