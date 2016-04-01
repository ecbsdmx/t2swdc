React = require 'react'
ReactDOM = require 'react-dom'
wizard = require('./reducers/wiz-reducers').wizard
categories = require('./reducers/cs-reducers').categories
dataflows = require('./reducers/df-reducers').dataflows
{combineReducers} = require 'redux'
{createStore} = require 'redux'
{App} = require './app/app'
csActions = require './actions/cs-actions'
data = require '../test/fixtures/data.json'

populateStore = (store) ->
  store.dispatch csActions.csLoaded [data]

class Main
  run: () ->
    reducers = combineReducers {categories, wizard, dataflows}
    store = createStore reducers
    populateStore store
    ele = React.createElement App, {store: store}
    ReactDOM.render(ele, document.getElementById "wdc-app")

module.exports = Main
