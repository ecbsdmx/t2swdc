should = require('chai').should()

{ActionTypes} = require '../../src/constants/action-types.coffee'

keyActions = [
  'CS_LOADED'
  'DSD_LOADED'
  'DATA_LOADED'
  'CATEGORY_SELECTED'
  'DATAFLOW_SELECTED'
  'FILTERS_CHANGED'
  'DATA_SELECTED'
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
