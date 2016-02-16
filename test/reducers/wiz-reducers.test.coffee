should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types.coffee'
wizReducers = require('../../src/reducers/wiz-reducers.coffee').wizard
actions = require '../../src/actions/wiz-actions.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Wizard reducers', ->
  initialState =
    selectedStep: 1
    selectedCategory: ''
    categoryschemes: []

  describe 'Reducer for changing step', ->
    it 'should have 1 as default value for the selected step', ->
      action = csActions.categorySelected 'test'
      state = wizReducers {}, action
      state.should.be.an('object').with.property('selectedStep').that.equals 1

    it 'should change the selected step', ->
      step = 3
      action = actions.wizstepChanged step
      state = wizReducers initialState, action
      state.should.be.an('object').with.property('selectedStep').
        that.equals step
