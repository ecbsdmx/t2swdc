should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types.coffee'
csReducers = require('../../src/reducers/cs-reducers.coffee').categories
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Category scheme reducers', ->
  initialState =
    selectedCategory: ''
    categoryschemes: []
    isFetching: false

  describe 'Reducer for category selection', ->
    it 'should change the selected category', ->
      id = 'test'
      action = csActions.categorySelected id
      state = csReducers initialState, action
      state.should.be.an('object').with.property('selectedCategory').
        that.equals id
    it 'should have null as default value for the selected category', ->
      action = csActions.csLoaded [{categories: []}]
      state = csReducers {}, action
      state.should.be.an('object').with.property('selectedCategory').
        that.is.a('null')

  describe 'Reducer for loading of category schemes', ->
    it 'should change the category schemes array', ->
      scheme = [{categories: []}]
      action = csActions.csLoaded scheme
      state = csReducers initialState, action
      state.should.be.an('object').with.property 'categoryschemes'
      state.categoryschemes.toJS().should.deep.equal(scheme)
    it 'should have an empty array as default for the category schemes', ->
      id = 'test'
      action = csActions.categorySelected id
      state = csReducers {}, action
      state.should.be.an('object').with.property 'categoryschemes'
      state.categoryschemes.toJS().should.be.empty
    it 'should generate an immutable collection', ->
      scheme = [{categories: []}]
      action = csActions.csLoaded scheme
      state = csReducers initialState, action
      state.should.be.an('object').with.property 'categoryschemes'
      state.categoryschemes.toJS().should.deep.equal(scheme)
      scheme.push {categories: [], id: 'test'}
      state.categoryschemes.toJS().should.not.deep.equal(scheme)

  describe 'Reducer for starting the load of category scheme', ->
    it 'should toggle the isLoading property', ->
      action = csActions.csLoading()
      state = csReducers initialState, action
      state.should.be.an('object').with.property('isFetching').that.equals true
