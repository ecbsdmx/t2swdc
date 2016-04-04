React = require 'react'
ReactDOM = require 'react-dom'
wizard = require('./reducers/wiz-reducers').wizard
categories = require('./reducers/cs-reducers').categories
dataflows = require('./reducers/df-reducers').dataflows
{combineReducers} = require 'redux'
{createStore} = require 'redux'
csActions = require './actions/cs-actions.coffee'
data = require '../test/fixtures/data.json'
wizContainer = require('./components/wizard/container.coffee').wizContainer
{Provider} = require 'react-redux'

populateStore = (store) ->
  store.dispatch csActions.csLoaded [data]

reducers = combineReducers {categories, wizard, dataflows}
store = createStore reducers
populateStore store

provider = React.createElement Provider, { store },
  React.createElement wizContainer

ReactDOM.render(provider, document.getElementById "wdc-app")
