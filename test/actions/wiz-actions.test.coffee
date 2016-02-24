should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types.coffee'
actions = require '../../src/actions/wiz-actions.coffee'

describe 'Wizard actions', ->

  describe 'Actions for changing steps', ->
    func = actions.wizstepChanged

    it 'should have the proper type', ->
      action = func 1
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.WIZSTEP_CHANGED

    it 'should have the new step as payload', ->
      step = 2
      action = func step
      action.should.have.property 'payload'
      action.payload.should.equal step

    it 'should have a number between 1 and 4 as step ', ->
      expect(func.bind(func, 0)).to.throw TypeError
      expect(func.bind(func, 5)).to.throw TypeError
      expect(func.bind(func, 'test')).to.throw TypeError
      (func 1).payload.should.equal 1
      (func 3).payload.should.equal 3
      (func 4).payload.should.equal 4
