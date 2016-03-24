should = require('chai').should()

{ActionTypes} = require '../../src/constants/action-types.coffee'

keyActions = [
  'FETCH_CS'
  'FETCH_CS_SUCCESS'
  'FETCH_CS_FAILURE'
  'FETCH_DATA_SUCCESS'
  'SELECT_CATEGORY'
  'SELECT_DATAFLOW'
  'CHANGE_FILTER'
  'SELECT_DATA'
  'CHANGE_WIZSTEP'
]

describe 'Action types', ->

  it 'should contain all key actions and only those', ->
    count = 0
    for key, value of ActionTypes
      keyActions.should.contain value
      count++
    count.should.equal keyActions.length


  it 'should be a string', ->
    for property of ActionTypes
      ActionTypes[property].should.be.a 'string'

  it 'should be uppercase', ->
    for property of ActionTypes
      value = ActionTypes[property]
      value.should.equal value.toUpperCase()
