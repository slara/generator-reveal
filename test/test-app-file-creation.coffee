path = require 'path'
yeoman = require 'yeoman-generator'
expect = require('chai').expect

assert = yeoman.assert
helpers = yeoman.test

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

        app.run {}, ->
            assert.file expected
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
            assert.file expected
            done()

    it 'generates package.json with correct version', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'package.json test'
            packageVersion: '1.2.3'

        app.run {}, ->
            assert.fileContent 'package.json', /"version": "1.2.3"/
            done()

    it 'uses defaults for .yo-rc.json config', ->
        (expect app.config.get 'deployToGithubPages').to.equal false
        (expect app.config.get 'useSass').to.equal false
        (expect app.config.get 'revealTheme').to.equal 'default'
        (expect app.config.get 'presentationTitle').to.equal 'Reveal.js and Yeoman is Awesomeness'
        (expect app.config.get 'packageVersion').to.equal '0.0.0'

    it 'updates .yo-rc.json config according to prompt input', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'ICanHazConfig'
            packageVersion: '0.1.0'
            revealTheme: 'simple'
            useSass: false
            deployToGithubPages: false

        app.run {}, ->
            # Wait for config to be written.
            setTimeout ->
                assert.fileContent '.yo-rc.json', /"generator-reveal"/
                assert.fileContent '.yo-rc.json', /"useSass": false/
                assert.fileContent '.yo-rc.json', /"revealTheme": "simple"/
                assert.fileContent '.yo-rc.json', /"presentationTitle": "ICanHazConfig"/
                assert.fileContent '.yo-rc.json', /"packageVersion": "0.1.0"/
                done()
            , 10

    it 'generates SASS support for themes', (done) ->
        helpers.mockPrompt app,
            presentationTitle: 'SASS Support 4 Custom Themes'
            packageVersion: '0.0.1'
            revealTheme: 'default'
            useSass: true
            deployToGithubPages: false

        app.run {}, ->
            assert.fileContent 'css/source/theme.scss', /@import "..\/..\/bower_components\/reveal.js\/css\/theme\/template\/theme";/
            assert.fileContent 'Gruntfile.coffee', /sass:/
            assert.fileContent 'Gruntfile.coffee', /'css\/\*.css'/
            assert.fileContent 'Gruntfile.coffee', /'css\/theme.css': 'css\/source\/theme.scss'/
            assert.fileContent 'templates/_index.html', /<link rel="stylesheet" href="css\/theme.css" id="theme">/
            assert.fileContent 'package.json', /"grunt-contrib-sass"/
            done()

    it 'generates Build control configuration for Github Pages Deployment', (done) ->
        helpers.mockPrompt app,
            pressentationTitle: 'Deploy to Github Pages'
            packageVersion: '0.0.1'
            useSass: false
            deployToGithubPages: true
            githubUsername: 'yeoman'
            githubRepository: 'reveal-js'


        app.run {}, ->
            assert.fileContent 'Gruntfile.coffee', /git@github.com:yeoman\/reveal-js.git/
            assert.fileContent 'Gruntfile.coffee', /grunt.registerTask 'deploy'/
            assert.fileContent 'package.json', /"grunt-build-control"/
            setTimeout ->
                assert.fileContent '.yo-rc.json', /"githubUsername": "yeoman"/
                assert.fileContent '.yo-rc.json', /"githubRepository": "reveal-js"/
                done()
            , 10

    it 'uses selected theme when not using sass', (done) ->
        helpers.mockPrompt app,
            pressentationTitle: 'Deploy to Github Pages'
            packageVersion: '0.0.1'
            useSass: false
            revealTheme: 'night'
            deployToGithubPages: false

        app.run {}, ->
            assert.fileContent 'templates/_index.html', /<link rel="stylesheet" href="bower_components\/reveal.js\/css\/theme\/night.css" id="theme">/
            done()

    after (done) ->
        # Clean up `temp`.
        helpers.testDirectory testDirectory, (err) ->
            return done(err) if err
            done()
