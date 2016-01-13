expect = require('chai').expect
lib = require('../src/index')

describe 'dev', ->
  it 'should be an array of strings', ->
    expect(lib.dev).not.to.be.empty
