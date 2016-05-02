{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'
Immutable = require 'immutable'

# Updates the state when the hierarchies have been loaded
hierarchies = (state = Immutable.Map([]), action) ->
  switch action.type
    when ActionTypes.FETCH_HCL
      if action.payload and not action.error
        Immutable.fromJS action.payload
      else state
    else state

# Updates the state to indicate that the process to fetch hierarchies has
# started
isFetching = (state = false, action) ->
  switch action.type
    when ActionTypes.FETCH_HCL
      if not action.payload and not action.error then true else false
    else state

# Updates the state when there was an error loading the hierarchies
error = (state = null, action) ->
  switch action.type
    when ActionTypes.FETCH_HCL
      if action.error then action.payload else null
    else state

# Combines together all the reducers related to hierarchical codelist
reducers = combineReducers {hierarchies, isFetching, error}

module.exports =
  hierarchies: reducers
