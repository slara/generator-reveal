'use strict'

path = require 'path'
fs = require 'fs'
yeoman = require 'yeoman-generator'
_assert = require 'assert'

coffeelint = require 'coffeelint'
jshintcli = require 'jshint/src/cli'

assert = yeoman.assert
helpers = yeoman.test

lint_generated_files = (cb) ->
    coffee_results = coffeelint.lint(
        fs.readFileSync('Gruntfile.coffee', encoding: 'utf-8'),
        {
            indentation:
                value: 4
            max_line_length:
                level: 'ignore'
        }
    )
    _assert.strictEqual coffee_results.length, 0, 'Generated Gruntfile.coffee is ill formatted'

    jshintcli.loadConfig path.join __dirname, '../app/templates/jshintrc'
    jshintcli.run args: ['js/loadhtmlslides.js'], reporter: (results, data) ->
        _assert.strictEqual results.length, 0, 'Generated js/loadhtmlslides.js is ill formatted'
        cb()

describe 'Generator Reveal', ->
    # SUT object.
    run_context = {}

    beforeEach ->
        run_context = helpers.run(path.join __dirname, '../app')
    afterEach (done) ->
        lint_generated_files(done)

    context 'with defaults', ->
        beforeEach (done) ->
            run_context.on 'end', done

        it 'should generate dotfiles', ->
            expected = [
                '.bowerrc'
                '.editorconfig'
                '.gitignore'
                '.jshintrc'
                '.yo-rc.json'
            ]

            assert.file expected

        it 'generates expected boilerplate files', ->
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

            assert.file expected

        it 'uses defaults for .yo-rc.json config', ->
            assert.fileContent '.yo-rc.json', '"deployToGithubPages": false'
            assert.fileContent '.yo-rc.json', '"useSass": false'
            assert.fileContent '.yo-rc.json', '"revealTheme": "default"'
            assert.fileContent '.yo-rc.json', '"presentationTitle": "Reveal.js and Yeoman is Awesomeness"'
            assert.fileContent '.yo-rc.json', 'packageVersion": "0.0.0"'

    it 'generates package.json with correct version', (done) ->
        run_context
            .withPrompts(
                presentationTitle: 'package.json test'
                packageVersion: '1.2.3'
            )
            .on 'end', ->
                assert.fileContent 'package.json', /"version": "1.2.3"/
                done()

    it 'updates .yo-rc.json config according to prompt input', (done) ->
        run_context
            .withPrompts(
                presentationTitle: 'ICanHazConfig'
                packageVersion: '0.1.0'
                revealTheme: 'simple'
                useSass: false
                deployToGithubPages: false
            )
            .on 'end', ->
                assert.fileContent '.yo-rc.json', /"generator-reveal"/
                assert.fileContent '.yo-rc.json', /"useSass": false/
                assert.fileContent '.yo-rc.json', /"revealTheme": "simple"/
                assert.fileContent '.yo-rc.json', /"presentationTitle": "ICanHazConfig"/
                assert.fileContent '.yo-rc.json', /"packageVersion": "0.1.0"/
                done()

    it 'generates SASS support for themes', (done) ->
        run_context
            .withPrompts(
                presentationTitle: 'SASS Support 4 Custom Themes'
                packageVersion: '0.0.1'
                revealTheme: 'default'
                useSass: true
                deployToGithubPages: false
            )
            .on 'end', ->
                assert.fileContent 'css/source/theme.scss', /@import "..\/..\/bower_components\/reveal.js\/css\/theme\/template\/theme";/
                assert.fileContent 'Gruntfile.coffee', /sass:/
                assert.fileContent 'Gruntfile.coffee', /'css\/\*.css'/
                assert.fileContent 'Gruntfile.coffee', /'css\/theme.css': 'css\/source\/theme.scss'/
                assert.fileContent 'templates/_index.html', /<link rel="stylesheet" href="css\/theme.css" id="theme">/
                assert.fileContent 'package.json', /"grunt-contrib-sass"/
                done()

    it 'generates Build control configuration for Github Pages Deployment', (done) ->
        run_context
            .withPrompts(
                pressentationTitle: 'Deploy to Github Pages'
                packageVersion: '0.0.1'
                useSass: false
                deployToGithubPages: true
                githubUsername: 'yeoman'
                githubRepository: 'reveal-js'
            )
            .on 'end', ->
                assert.fileContent 'Gruntfile.coffee', /git@github.com:yeoman\/reveal-js.git/
                assert.fileContent 'Gruntfile.coffee', /grunt.registerTask 'deploy'/
                assert.fileContent 'package.json', /"grunt-build-control"/
                assert.fileContent '.yo-rc.json', /"githubUsername": "yeoman"/
                assert.fileContent '.yo-rc.json', /"githubRepository": "reveal-js"/
                done()

    it 'uses selected theme when not using sass', (done) ->
        run_context
            .withPrompts(
                pressentationTitle: 'Deploy to Github Pages'
                packageVersion: '0.0.1'
                useSass: false
                revealTheme: 'night'
                deployToGithubPages: false
            )
            .on 'end', ->
                assert.fileContent 'templates/_index.html', /<link rel="stylesheet" href="bower_components\/reveal.js\/css\/theme\/night.css" id="theme">/
                done()
