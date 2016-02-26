should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types.coffee'
dfActions = require '../../src/actions/df-actions.coffee'

describe 'Dataflows actions', ->

  describe 'Actions creators', ->
    it 'should allow creating DATAFLOW_SELECTED actions', ->
      dfActions.should.have.property 'dataflowSelected'

  describe 'Actions for dataflow selection', ->
    func = dfActions.dataflowSelected

    it 'should have the proper type', ->
      action = func 'EXR'
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.DATAFLOW_SELECTED

    it 'should have the unique id of the dataflow as payload', ->
      id = 'EXR'
      action = func id
      action.should.have.property 'payload'
      action.payload.should.equal id

    it 'should have a non-empty string as unique id', ->
      expect(func.bind(func, 2)).to.throw TypeError
      expect(func.bind(func, '')).to.throw TypeError
      expect(func.bind(func, ' ')).to.throw TypeError
