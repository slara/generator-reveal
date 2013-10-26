fs = require 'fs'
path = require 'path'
yeoman = require 'yeoman-generator'
semver = require 'semver'

module.exports = class SlideGenerator extends yeoman.generators.NamedBase
    constructor: ->
        yeoman.generators.NamedBase.apply @, arguments
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

    files: ->
        appPath = process.cwd()
        fullPath = path.join appPath, '/slides/list.json'
        list = require fullPath

        if @options.markdown
            @filename = "#{@_.slugify(@name)}.md"
            @log.info 'Using Markdown.'

            if @options.notes
                @template 'slide-withnotes.md', "slides/#{@filename}"
            else
                @template 'slide.md', "slides/#{@filename}"

        else
            @filename = "#{@_.slugify(@name)}.html"
            @log.info 'Using HTML.'

            if @options.notes
                @template 'slide-withnotes.html', "slides/#{@filename}"
            else
                @template 'slide.html', "slides/#{@filename}"

        if @options.attributes
            @log.info "Appending slides/#{@filename} to slides/list.json."
            list.push filename: @filename, attr: 'data-background': '#ff0000'
        else
            @log.info "Appending slides/#{@filename} to slides/list.json."
            list.push @filename

        fs.writeFileSync fullPath, JSON.stringify list, null, 4
