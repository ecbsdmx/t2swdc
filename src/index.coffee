React = require 'react'
ReactDOM = require 'react-dom'
wizard = require('./reducers/wiz-reducers.coffee').wizard
categories = require('./reducers/cs-reducers.coffee').categories
{combineReducers} = require 'redux'
{createStore} = require 'redux'
{App} = require './app/app.coffee'
csActions = require './actions/cs-actions.coffee'

populateStore = (store) ->
  [id, name] = ['abcd', 'category scheme']
  cats = [
    {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
    {id:'B', name:'catB', dataflows:[]},
  ]
  payload = [{id: id, name: name, categories: cats}]
  store.dispatch csActions.csLoaded payload

class Main
  run: () ->
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    populateStore store
    ele = React.createElement App, {store: store}
    ReactDOM.render(ele, document.getElementById "wdc-app")

module.exports = Main
