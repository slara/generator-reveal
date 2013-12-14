expect = require('chai').expect

describe 'Generator Reveal', ->
    it 'can be imported without blowing up', ->
        app = require '../app'
        (expect app).to.be.ok

describe 'Sub-Generator Slide', ->
    it 'can be imported without blowing up', ->
        slide = require '../slide'
        (expect slide).to.be.ok
