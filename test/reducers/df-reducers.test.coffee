should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types.coffee'
dfReducers = require('../../src/reducers/df-reducers.coffee').dataflows
dfActions = require '../../src/actions/df-actions.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Dataflow reducers', ->
  initialState =
    selectedDataflow: ''

  describe 'Reducer for dataflow selection', ->
    it 'should change the selected dataflow', ->
      id = 'EXR'
      action = dfActions.dataflowSelected id
      state = dfReducers initialState, action
      state.should.be.an('object').with.property('selectedDataflow').
        that.equals id
    it 'should have null as default value for the selected dataflow', ->
      action = csActions.csLoaded [{categories: []}]
      state = dfReducers {}, action
      state.should.be.an('object').with.property('selectedDataflow').
        that.is.a('null')
