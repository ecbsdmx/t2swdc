expect = require('chai').expect
should = require('chai').should()

lib = require '../src/index'

describe 'dev', ->
  it 'should be an array of strings', ->
    expect(lib.dev).not.to.be.empty

  describe 'lib.dev', ->
    it 'should contain names', ->
      lib.dev.should.include 'Xavier'
