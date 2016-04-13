# React stuff
React = require 'react'
ReactDOM = require 'react-dom'

# Redux actions
csActions = require './actions/cs-actions.coffee'
fltrActions = require './actions/fltr-actions.coffee'

# Redux reducers
{categories} = require('./reducers/cs-reducers')
{dataflows} = require('./reducers/df-reducers')
{filters} = require('./reducers/fltr-reducers')

# Redux container
{wizContainer} = require('./components/wizard/container.coffee')

# Redux core
{createStore, applyMiddleware, combineReducers} = require 'redux'
{Provider} = require 'react-redux'
thunkMiddleware = require('redux-thunk').default

data = require '../test/fixtures/data.json'

populateStore = (store) ->
  store.dispatch csActions.csLoaded [data]

reducers = combineReducers {categories, dataflows, filters}
store = createStore reducers, applyMiddleware thunkMiddleware
populateStore store

provider = React.createElement Provider, { store },
  React.createElement wizContainer

ReactDOM.render(provider, document.getElementById "wdc-app")
