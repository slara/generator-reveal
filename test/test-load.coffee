assert  = require 'assert'

describe 'Generator Reveal', ->
    it 'can be imported without blowing up', ->
        app = require '../app'
        assert.ok app

describe 'Sub-Generator Slide', ->
    it 'can be imported without blowing up', ->
        slide = require '../slide'
        assert.ok slide
