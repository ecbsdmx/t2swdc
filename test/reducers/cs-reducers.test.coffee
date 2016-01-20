should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types.coffee'
{csReducers} = require '../../src/reducers/cs-reducers.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Category scheme reducers', ->
  initialState =
    selectedCategory: ''
    categoryschemes: []

  describe 'Reducer for category selection', ->
    it 'should change the selected category', ->
      id = 'test'
      action = csActions.categorySelected id
      state = csReducers initialState, action
      state.should.be.an('object')
      state.selectedCategory.should.equal id
    it 'should have null as default value for the selected category', ->
      action = csActions.csLoaded {categoryschemes: [{categories: []}]}
      state = csReducers {}, action
      state.should.be.an('object')
      state.should.have.property('selectedCategory')
      expect(state.selectedCategory).to.be.null

  describe 'Reducer for loading of category schemes', ->
    it 'should change the category schemes array', ->
      scheme = {categoryschemes: [{categories: []}]}
      action = csActions.csLoaded scheme
      state = csReducers initialState, action
      state.should.be.an('object')
      state.should.have.property('categoryschemes')
      state.categoryschemes.toJS().should.deep.equal(scheme)
    it 'should have an empty array as default for the category schemes', ->
      id = 'test'
      action = csActions.categorySelected id
      state = csReducers {}, action
      state.should.be.an('object')
      state.should.have.property('categoryschemes')
      state.categoryschemes.toJS().should.be.empty
    it 'should generate an immutable collection', ->
      scheme = {categoryschemes: [{categories: []}]}
      action = csActions.csLoaded scheme
      state = csReducers initialState, action
      state.should.be.an('object')
      state.should.have.property('categoryschemes')
      state.categoryschemes.toJS().should.deep.equal(scheme)
      scheme.categoryschemes.push {categories: [], id: 'test'}
      state.categoryschemes.toJS().should.not.deep.equal(scheme)
