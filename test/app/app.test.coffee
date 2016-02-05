should = require('chai').should()
{store} = require '../../src/app/app.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Store', ->
  it 'should set an initial state with the default values', ->
    state = store.getState()
    state.should.be.an('object').with.property('selectedCategory').
      that.is.a('null')
    state.should.have.property 'categoryschemes'
    state.categoryschemes.toJS().should.be.empty

  it 'should change the state when an action is dispatched', ->
    id = 'test'
    action = csActions.categorySelected id
    store.dispatch(action)
    state = store.getState()
    state.should.have.property('selectedCategory').that.equals id
    state.should.have.property 'categoryschemes'
    state.categoryschemes.toJS().should.be.empty
