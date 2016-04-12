should = require('chai').should()

{ActionTypes} = require '../../src/constants/action-types'

keyActions = [
  'FETCH_CS'
  'FETCH_DATA'
  'SELECT_CATEGORY'
  'SELECT_DATAFLOW'
  'SELECT_DATA'
  'SELECT_MEASURE'
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
