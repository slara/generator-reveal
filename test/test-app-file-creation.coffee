path = require 'path'
helpers = require('yeoman-generator').test
expect = require('chai').expect
testDirectory = path.join __dirname, 'temp'

describe 'Generator Reveal', ->
    # SUT object.
    app = {}

    beforeEach (done) ->
        helpers.testDirectory testDirectory, (err) ->
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

    it 'uses defaults for .yo-rc.json config', ->
        (expect app.config.get 'useSass').to.equal false
        (expect app.config.get 'presentationTitle').to.equal 'Reveal.js and Yeoman is Awesomeness'
        (expect app.config.get 'packageVersion').to.equal '0.0.0'

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

    after (done) ->
        # Clean up `temp`.
        helpers.testDirectory testDirectory, (err) ->
            return done(err) if err
            done()
