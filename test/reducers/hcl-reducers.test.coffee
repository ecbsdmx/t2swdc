should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types.coffee'
hclReducers = require('../../src/reducers/hcl-reducers.coffee').hierarchies
hclActions = require '../../src/actions/hcl-actions.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Hierarchies reducers', ->
  initialState =
    hierarchies: {}
    isFetching: false

  describe 'Reducer for loading of hierarchies', ->
    it 'should change the hierarchies object', ->
      hierarchy = {mu: ['BE'], nmu: ['DK']}
      action = hclActions.hclLoaded hierarchy
      state = hclReducers initialState, action
      state.should.be.an('object').with.property 'hierarchies'
      state.hierarchies.toJS().should.deep.equal hierarchy
    it 'should have an empty object as default for the hierarchies', ->
      id = 'test'
      action = csActions.categorySelected id
      state = hclReducers {}, action
      state.should.be.an('object').with.property 'hierarchies'
      state.hierarchies.toJS().should.be.empty
    it 'should generate an immutable object', ->
      hierarchy = {mu: ['BE'], nmu: ['DK']}
      action = hclActions.hclLoaded hierarchy
      state = hclReducers initialState, action
      state.should.be.an('object').with.property 'hierarchies'
      state.hierarchies.toJS().should.deep.equal hierarchy
      hierarchy.mu.push 'LU'
      state.hierarchies.toJS().should.not.deep.equal hierarchy

  describe 'Reducer for starting the load of hierarchies', ->
    it 'should toggle the isLoading property', ->
      action = hclActions.hclLoading()
      state = hclReducers initialState, action
      state.should.be.an('object').with.property('isFetching').that.equals true

  describe 'Reducer handling errors when fetching the hierarchies', ->
    it 'should change the error property', ->
      error = new Error 'Problem'
      action = hclActions.hclLoaded error
      state = hclReducers initialState, action
      state.should.be.an('object').with.property 'error'
      state.error.should.equal error
    it 'should have null as default value for the error property', ->
      action = csActions.categorySelected '2'
      state = hclReducers {}, action
      state.should.be.an('object').with.property('error').that.is.a 'null'
