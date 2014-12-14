'use strict'

path = require 'path'
yeoman = require 'yeoman-generator'
semver = require 'semver'
yosay = require 'yosay'
chalk = require 'chalk'


module.exports = class RevealGenerator extends yeoman.generators.Base
    initializing: ->
        @pkg = @fs.readJSON path.join __dirname, '../package.json'

        # Setup config defaults.
        @config.defaults
            presentationTitle: 'Reveal.js and Yeoman is Awesomeness'
            packageVersion: '0.0.0'
            revealTheme: 'default'
            useSass: false
            deployToGithubPages: false

    prompting:
        askFor: ->
            cb = @async()
            # Have Yeoman greet the user.
            @log yosay()
            @log chalk.magenta(
                'This includes the amazing Reveal.js Framework\n' +
                'and a Grunt file for your presentation pleasure.\n'
            )
            prompts = [
                {
                    name: 'presentationTitle'
                    message: 'What are you going to talk about?'
                    default: @config.get 'presentationTitle'
                }
                {
                    name: 'packageVersion'
                    message: 'What version should we put in the package.json file?'
                    default: @config.get 'packageVersion'
                    validate: (input) ->
                        return 'Please enter a correct semver version, i.e. MAJOR.MINOR.PATCH.' unless semver.valid input
                        true
                }
                {
                    name: 'useSass'
                    message: 'Do you want to use SASS to create a custom theme? This requires you to have Ruby and Sass installed.'
                    type: 'confirm'
                    default: @config.get 'useSass'
                }
                {
                    name: 'revealTheme'
                    type: 'list'
                    message: 'What Reveal.js theme would you like to use?'
                    when: (props) -> props.useSass is off
                    choices: @fs.readJSON path.join __dirname, './theme_choices.json'
                    default: @config.get 'revealTheme'
                }
                {
                    name: 'deployToGithubPages'
                    message: 'Do you want to deploy your presentation to Github Pages? This requires an empty Github repository.'
                    type: 'confirm'
                    default: @config.get 'deployToGithubPages'
                }
                {
                    name: 'githubUsername'
                    message: 'What is your Github username?'
                    default: @config.get 'githubUsername'
                    when: (props) -> props.deployToGithubPages is on
                }
                {
                    name: 'githubRepository'
                    message: 'What is the Github repository name?'
                    default: @config.get 'githubRepository'
                    when: (props) -> props.deployToGithubPages is on
                }
            ]
            @prompt prompts, (props) =>
                # Write answers to `config`.
                @config.set 'presentationTitle', props.presentationTitle
                @config.set 'packageVersion', props.packageVersion
                @config.set 'useSass', props.useSass
                @config.set 'revealTheme', props.revealTheme
                @config.set 'deployToGithubPages', props.deployToGithubPages
                @config.set 'githubUsername', props.githubUsername
                @config.set 'githubRepository', props.githubRepository
                cb()

    writing:
        app: ->
            @fs.copyTpl @templatePath('_index.md'), @destinationPath('slides/index.md'), @
            @fs.copyTpl @templatePath('_Gruntfile.coffee'), @destinationPath('Gruntfile.coffee'), @
            @fs.copyTpl @templatePath('_package.json'), @destinationPath('package.json'), @
            @fs.copyTpl @templatePath('_bower.json'), @destinationPath('bower.json'), @
            @fs.copy @templatePath('loadhtmlslides.js'), @destinationPath('js/loadhtmlslides.js')
            @fs.copy @templatePath('list.json'), @destinationPath('slides/list.json')
            @fs.copy @templatePath('theme.scss'), @destinationPath('css/source/theme.scss') if @config.get 'useSass'

            # inception. use `@copy`, see https://github.com/yeoman/generator/issues/700#issuecomment-63501734
            @copy @templatePath('__index.html'), @destinationPath('templates/_index.html')
            @copy @templatePath('__section.html'), @destinationPath('templates/_section.html')

        projectfiles: ->
            @fs.copy @templatePath('editorconfig'), @destinationPath('.editorconfig')
            @fs.copy @templatePath('jshintrc'), @destinationPath('.jshintrc')

        runtime: ->
            @fs.copy @templatePath('bowerrc'), @destinationPath('.bowerrc')
            @fs.copy @templatePath('gitignore'), @destinationPath('.gitignore')

    install: ->
        @installDependencies skipInstall: @options['skip-install']
