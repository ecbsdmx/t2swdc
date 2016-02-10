React = require 'react'
ReactDOM = require 'react-dom'
{createStore} = require 'redux'
{csReducers} = require './reducers/cs-reducers.coffee'
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
    store = createStore csReducers
    populateStore store
    ele = React.createElement App, {store: store}
    ReactDOM.render(ele, document.getElementById "wdc-app")
module.exports = Main
