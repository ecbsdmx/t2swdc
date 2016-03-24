should = require('chai').should()

{ActionTypes} = require '../../src/constants/action-types.coffee'

keyActions = [
  'FETCH_CS_SUCCESS'
  'FETCH_DATA_SUCCESS'
  'SELECT_CATEGORY'
  'SELECT_DATAFLOW'
  'CHANGE_FILTER'
  'SELECT_DATA'
]

describe 'Action types', ->
  it 'should contain all key actions', ->
    for action in keyActions
      ActionTypes.should.have.property action

  it 'should be a string', ->
    for property of ActionTypes
      ActionTypes[property].should.be.a 'string'

  it 'should be uppercase', ->
    for property of ActionTypes
      value = ActionTypes[property]
      value.should.equal value.toUpperCase()
