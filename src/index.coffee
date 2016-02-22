React = require 'react'
ReactDOM = require 'react-dom'
wizard = require('./reducers/wiz-reducers.coffee').wizard
categories = require('./reducers/cs-reducers.coffee').categories
{combineReducers} = require 'redux'
{createStore} = require 'redux'
{App} = require './app/app.coffee'
csActions = require './actions/cs-actions.coffee'
data = require './data.json'

populateStore = (store) ->
  store.dispatch csActions.csLoaded [data]

class Main
  run: () ->
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    populateStore store
    ele = React.createElement App, {store: store}
    ReactDOM.render(ele, document.getElementById "wdc-app")

module.exports = Main
