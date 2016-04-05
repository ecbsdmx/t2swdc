should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types'
fltrReducers = require('../../src/reducers/fltr-reducers').filters
fltrActions = require '../../src/actions/fltr-actions'
csActions = require '../../src/actions/cs-actions'

describe 'Data reducers', ->
  initialState =
    selectedData: ''

  describe 'Reducer for data selection', ->
    it 'should change the selected data', ->
      url = 'http://ws-entry-point.com/data/TEST'
      action = fltrActions.dataSelected url
      state = fltrReducers initialState, action
      state.should.be.an('object').with.property('selectedData').that.equals url
    it 'should have null as default value for the selected data', ->
      action = csActions.csLoaded [{categories: []}]
      state = fltrReducers {}, action
      state.should.be.an('object').with.property('selectedData').
        that.is.a('null')
