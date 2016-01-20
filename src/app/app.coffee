{createStore} = require 'redux'
{csReducers} = require '../reducers/cs-reducers.coffee'

store = createStore(csReducers)

module.exports =
  store: store
