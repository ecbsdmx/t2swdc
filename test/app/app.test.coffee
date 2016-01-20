should = require('chai').should()
expect = require('chai').expect
{store} = require '../../src/app/app.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Store', ->
  it 'should set an initial state with the default values', ->
    state = store.getState()
    state.should.be.an('object')
    state.should.have.property('selectedCategory')
    expect(state.selectedCategory).to.be.null
    state.should.have.property('categoryschemes')
    state.categoryschemes.toJS().should.be.empty

  it 'should change the state when an action is dispatched', ->
    id = 'test'
    action = csActions.categorySelected id
    store.dispatch(action)
    state = store.getState()
    state.should.have.property('selectedCategory')
    state.selectedCategory.should.equal id
    state.should.have.property('categoryschemes')
    state.categoryschemes.toJS().should.be.empty
