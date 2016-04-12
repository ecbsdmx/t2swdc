should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types'
fltrReducers = require('../../src/reducers/fltr-reducers').filters
fltrActions = require '../../src/actions/fltr-actions'
csActions = require '../../src/actions/cs-actions'

describe 'Data reducers', ->
  initialState =
    selectedData: ''
    selectedMeasure: null

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

  describe 'Reducer for measure dimension selection', ->
    it 'should change the selected measure', ->
      action = fltrActions.measureSelected 2
      state = fltrReducers initialState, action
      state.should.be.an('object').with.
        property('selectedMeasure').that.equals 2
    it 'should have null as default value for the selected measure', ->
      action = csActions.csLoaded [{categories: []}]
      state = fltrReducers {}, action
      state.should.be.an('object').with.property('selectedMeasure').
        that.is.a 'null'

  describe 'Reducer for starting the data loading', ->
    it 'should toggle the isLoading property', ->
      action = fltrActions.dataLoading()
      state = fltrReducers initialState, action
      state.should.be.an('object').with.property('isFetching').that.equals true


  describe 'Reducer for data loading', ->
    it 'should change the data object', ->
      data = {header:{}, structure:{}, dataSets:[]}
      action = fltrActions.dataLoaded data
      state = fltrReducers initialState, action
      state.should.be.an('object').with.property 'data'
      state.data.toJS().should.deep.equal data
    it 'should have an empty object as default for the data', ->
      id = 'test'
      action = fltrActions.measureSelected 2
      state = fltrReducers {}, action
      state.should.be.an('object').with.property 'data'
      state.data.toJS().should.deep.equal {}
    it 'should generate an immutable object', ->
      data = {header:{}, structure:{}, dataSets:[]}
      action = fltrActions.dataLoaded data
      state = fltrReducers initialState, action
      state.should.be.an('object').with.property 'data'
      state.data.toJS().should.deep.equal data
      data.error = 'test'
      state.data.toJS().should.not.deep.equal data
      state.data.toJS().should.not.have.property 'data'
