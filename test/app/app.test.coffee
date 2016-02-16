React = require 'react'
{createStore} = require 'redux'
categories = require('../../src/reducers/cs-reducers.coffee').categories
wizard = require('../../src/reducers/wiz-reducers.coffee').wizard
{combineReducers} = require 'redux'
should = require('chai').should()
{mount} = require 'enzyme'
csActions = require '../../src/actions/cs-actions.coffee'
jsdom = require 'mocha-jsdom'
{App} = require '../../src/app/app.coffee'

describe 'App component', ->

  jsdom()

  it 'should populate an App component', ->
    [id, name] = ['abcd', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    cscEle  = React.createElement App, {store: store}
    wrapper = mount cscEle
    wrapper.find('div.wizard').should.have.length 1
    wrapper.find('div.steps-container').should.have.length 1
    wrapper.find('div.step-content').should.have.length 1
    wrapper.find('div.step-pane').should.have.length 4
    wrapper.find('div.active').should.have.length 1
    wrapper.find('li.active').should.have.length 1
