React = require 'react'
{createStore} = require 'redux'
{csReducers} = require '../../src/reducers/cs-reducers.coffee'
should = require('chai').should()
{shallow} = require 'enzyme'
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
    store = createStore csReducers
    store.dispatch csActions.csLoaded payload
    cscEle  = React.createElement App, {store: store}
    wrapper = shallow cscEle
    scheme = """
    <div id="app"><div id="cs_#{id}" class="list-group">\
    <a id="cat_A" href="#" class="list-group-item">\
    <span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item">\
    <span class="badge badge-primary">0</span>catB</a>\
    </div></div>
    """
    wrapper.html().should.equal scheme
