assert = require 'assert'

describe 'Generator Reveal', ->
    it 'can be imported without blowing up', ->
        app = require '../app'
        assert.equal !!app, true

describe 'Sub-Generator Slide', ->
    it 'can be imported without blowing up', ->
        slide = require '../slide'
        assert.equal !!slide, true
