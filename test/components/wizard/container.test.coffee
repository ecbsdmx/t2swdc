React = require 'react'
{createStore} = require 'redux'
categories = require('../../../src/reducers/cs-reducers.coffee').categories
wizard = require('../../../src/reducers/wiz-reducers.coffee').wizard
{combineReducers} = require 'redux'
should = require('chai').should()
{describeWithDOM, mount, spyLifecycle, shallow} = require 'enzyme'
wiz = require('../../../src/components/wizard/container.coffee').wizContainer
csActions = require '../../../src/actions/cs-actions.coffee'
wizActions = require '../../../src/actions/wiz-actions.coffee'
jsdom = require 'mocha-jsdom'

describe 'Wizard container component', ->

  jsdom()

  it 'should populate a Wizard Steps component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find('.steps-container').should.have.length 1
    steps = wrapper.find('.steps-container')
    steps.find('li').should.have.length 4

  it 'should update a Wizard Steps component with the next step', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    store.dispatch wizActions.wizstepChanged 2
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find('.steps-container').should.have.length 1
    steps = wrapper.find('.steps-container')
    steps.find('.active').should.have.length 1
    steps.find('.active').html().should.contain 'datasets'

  it 'should populate a Wizard Actions component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find('.actions').should.have.length 1
    steps = wrapper.find('.actions')
    steps.find('button').should.have.length 2

  it 'should populate a Category Scheme component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find("#cs_#{id}").should.have.length 1

  it 'should update the store with the selected category', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find('#cat_A').should.have.length 1
    wrapper.find('#cat_A').simulate 'click'
    store.getState().categories.selectedCategory.should.equal 'A'

  it 'should update the store with the next wizard step', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement wiz, {store: store}
    wrapper = mount ele
    wrapper.find('#cat_A').should.have.length 1
    wrapper.find('#cat_A').simulate 'click'
    store.getState().wizard.selectedStep.should.equal 2
