path = require 'path'
yeoman = require 'yeoman-generator'
semver = require 'semver'

module.exports = class RevealGenerator extends yeoman.generators.Base

    constructor: (args, options) ->
        yeoman.generators.Base.apply @, arguments
        @on 'end', ->
            @installDependencies skipInstall: options['skip-install']
        @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

    askFor: ->
        cb = @async()
        # Have Yeoman greet the user.
        console.log @yeoman
        prompts = [
            {
                name: 'presentationTitle'
                message: 'What are you going to talk about?'
                default: 'My Topic Of Choice'
            }
            {
                name: 'packageVersion'
                message: 'What version should we put in the package.json file?'
                default: '0.0.0'
                validate: (input) ->
                    return 'Please enter a correct semver version, i.e. MAJOR.MINOR.PATCH.' unless semver.valid input
                    true
            }
            {
                name: 'useSass'
                message: 'Do you want to use SASS to create a custom theme? This requires you to have Ruby and Sass installed.'
                type: 'confirm'
                default: false
            }
        ]
        @prompt prompts, (props) =>
            @presentationTitle = props.presentationTitle
            @packageVersion = props.packageVersion
            @useSass = props.useSass
            cb()

    app: ->
        @template '_index.md', 'slides/index.md'
        @template '_Gruntfile.coffee', 'Gruntfile.coffee'
        @template '_index.tpl', 'index.tpl'
        @template '_package.json', 'package.json'
        @template '_bower.json', 'bower.json'
        @copy 'loadhtmlslides.js', 'js/loadhtmlslides.js'
        @copy 'list.json', 'slides/list.json'

        @copy 'theme.scss', 'css/source/theme.scss' if @useSass

    projectfiles: ->
        @copy 'editorconfig', '.editorconfig'
        @copy 'jshintrc', '.jshintrc'

    runtime: ->
        @copy 'bowerrc', '.bowerrc'
        @copy 'gitignore', '.gitignore'


