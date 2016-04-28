React = require 'react'
{createStore} = require 'redux'
{categories} = require('../../../src/reducers/cs-reducers')
{dataflows} = require('../../../src/reducers/df-reducers')
{filters} = require('../../../src/reducers/fltr-reducers')
{combineReducers} = require 'redux'
should = require('chai').should()
{describeWithDOM, mount, spyLifecycle, shallow} = require 'enzyme'
{WizardContainer} = require('../../../src/components/wizard/container')
csActions = require '../../../src/actions/cs-actions'
dfActions = require '../../../src/actions/df-actions'

describe 'Wizard container component', ->

  it 'should populate a Wizard Steps component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, dataflows, filters}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement WizardContainer, {store: store}
    wrapper = mount ele
    wrapper.find('.steps-container').should.have.length 1
    steps = wrapper.find('.steps-container')
    steps.find('li').should.have.length 3

  it 'should populate a Wizard Actions component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, dataflows, filters}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement WizardContainer, {store: store}
    wrapper = mount ele
    wrapper.find('.actions').should.have.length 1
    steps = wrapper.find('.actions')
    steps.find('button').should.have.length 1

  it 'should populate a Category Scheme component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, dataflows, filters}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    ele  = React.createElement WizardContainer, {store: store}
    wrapper = mount ele
    wrapper.find("#cs_#{id}").should.have.length 1

  it 'should populate a Dataflows component', ->
    [id, name] = ['xyz', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:[{id: 'flow1', name: 'flow1Name'}]},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, dataflows, filters}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    store.dispatch csActions.categorySelected 'A'
    ele  = React.createElement WizardContainer, {store: store}
    wrapper = mount ele
    wrapper.find("#dataflows").should.have.length 1
    wrapper.find("#df_flow1").should.have.length 1
