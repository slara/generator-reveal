'use strict'

fs = require 'fs'
path = require 'path'
Generator = require 'yeoman-generator'
slugify = require 'underscore.string/slugify'

module.exports = class SlideGenerator extends Generator
    constructor: ->
        Generator.apply this, arguments
        @argument 'name', type: String, required: true

    configuring: ->
        @option 'notes',
            desc: 'Include speaker notes'
            type: Boolean
            default: false
        @option 'markdown',
            desc: 'Use markdown'
            type: Boolean
            default: false
        @option 'attributes',
            desc: 'Include attributes on slide sections, e.g. data-background, class, etc.'
            type: Boolean
            default: false

    writing: ->
        fullPath = @destinationPath('slides/list.json')
        list = @fs.readJSON fullPath

        if @options.markdown
            @filename = "#{slugify(@options.name)}.md"
            @log.info 'Using Markdown.'

            if @options.notes
                @fs.copyTpl @templatePath('slide-withnotes.md'), @destinationPath("slides/#{@filename}"), name: @options.name
            else
                @fs.copyTpl @templatePath('slide.md'), @destinationPath("slides/#{@filename}"), name: @options.name

        else
            @filename = "#{slugify(@options.name)}.html"
            @log.info 'Using HTML.'

            if @options.notes
                @fs.copyTpl @templatePath('slide-withnotes.html'), @destinationPath("slides/#{@filename}"), name: @options.name
            else
                @fs.copyTpl @templatePath('slide.html'), @destinationPath("slides/#{@filename}"), name: @options.name

        if @options.attributes
            @log.info "Appending slides/#{@filename} to slides/list.json."
            list.push filename: @filename, attr: 'data-background': '#ff0000'
        else
            @log.info "Appending slides/#{@filename} to slides/list.json."
            list.push @filename

        # TODO
        # replace with @fs.writeJSON as soon as @fs supports it
        # then we can remove the `fs` dependency.
        fs.writeFileSync fullPath, JSON.stringify list, null, 4
