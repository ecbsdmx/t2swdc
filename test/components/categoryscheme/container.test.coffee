React = require 'react'
{createStore} = require 'redux'
{csReducers} = require '../../../src/reducers/cs-reducers.coffee'
should = require('chai').should()
{describeWithDOM, mount, spyLifecycle, shallow} = require 'enzyme'
{csc} = require('../../../src/components/categoryscheme/container.coffee')
csActions = require '../../../src/actions/cs-actions.coffee'
jsdom = require 'mocha-jsdom'

describe 'Category Scheme container component', ->

  jsdom()

  it 'should populate a Category Scheme component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    store = createStore csReducers
    store.dispatch csActions.csLoaded payload
    cscEle  = React.createElement csc, {store: store}
    wrapper = shallow cscEle
    scheme = """
    <div id="cs_#{id}" class="list-group">\
    <a id="cat_A" href="#" class="list-group-item">\
    <span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item">\
    <span class="badge badge-primary">0</span>catB</a>\
    </div>
    """
    wrapper.html().should.equal scheme

  it 'should start with an empty state', ->
    store = createStore csReducers
    cscEle  = React.createElement csc, {store: store}
    wrapper = shallow cscEle
    empty = '<div id="cs_" class="list-group"></div>'
    wrapper.html().should.equal empty

  it 'should call componentDidMount', ->
    store = createStore csReducers
    cscEle  = React.createElement csc, {store: store}
    spyLifecycle csc
    wrapper = mount cscEle
    csc.prototype.componentDidMount.calledOnce.should.be.true

  it 'should update the store with the selected category', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    store = createStore csReducers
    store.dispatch csActions.csLoaded payload
    cscEle  = React.createElement csc, {store: store}
    wrapper = mount cscEle
    wrapper.find('#cat_A').should.have.length 1
    wrapper.find('#cat_A').simulate 'click'
    store.getState().selectedCategory.should.equal 'A'
