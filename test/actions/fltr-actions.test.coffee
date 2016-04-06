should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types.coffee'
fltrActions = require '../../src/actions/fltr-actions.coffee'

describe 'Filters actions', ->

  describe 'Actions creators', ->
    it 'should allow creating SELECT_DATA actions', ->
      fltrActions.should.have.property 'dataSelected'

  describe 'Actions for data selection', ->
    func = fltrActions.dataSelected

    it 'should have the proper type', ->
      action = func 'http://ws-entry-point.com/data/TEST'
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.SELECT_DATA

    it 'should have the data query url as payload', ->
      url = 'http://ws-entry-point.com/data/TEST'
      action = func url
      action.should.have.property 'payload'
      action.payload.should.equal url

    it 'should have a non-empty string as iput', ->
      expect(func.bind(func, 2)).to.throw TypeError
      expect(func.bind(func, '')).to.throw TypeError
      expect(func.bind(func, ' ')).to.throw TypeError

  describe 'Actions for measure selection', ->
    func = fltrActions.measureSelected

    it 'should have the proper type', ->
      action = func 1
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.SELECT_MEASURE

    it 'should have the position of the dimension as payload', ->
      action = func 1
      action.should.have.property 'payload'
      action.payload.should.equal 1

    it 'should be possible to reset the measure dimension', ->
      action = func null
      action.should.be.an('object').with.property('payload').that.is.a 'null'

    it 'should have an integer as iput', ->
      expect(func.bind(func, 'test')).to.throw TypeError
      expect(func.bind(func, [])).to.throw TypeError
      expect(func.bind(func, {})).to.throw TypeError
