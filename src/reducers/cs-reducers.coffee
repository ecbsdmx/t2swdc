{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'
Immutable = require 'immutable'

# Updates the state when a user has selected a category
#
# @param [Object] the current value for the selectedCategory property
# @param [Object] the action received
#
# @return the new value for the selectedCategory property if the action is of
# the expected type
#
selectedCategory = (state = null, action) ->
  switch action.type
    when ActionTypes.SELECT_CATEGORY then action.payload
    else state

# Updates the state when the category schemes have been loaded
#
# @param [Object] the current value for the categoryschemes property
# @param [Object] the action received
#
# @return the new value for the categoryschemes property if the action is of
# the expected type
#
categoryschemes = (state = Immutable.List([]), action) ->
  switch action.type
    when ActionTypes.FETCH_CS
      if action.payload and not action.error
        Immutable.fromJS(action.payload)
      else state
    else state

# Updates the state to indicate that the process to fetch category schemes has
# started
isFetching = (state = false, action) ->
  switch action.type
    when ActionTypes.FETCH_CS
      if not action.payload and not action.error then true else false
    else state

# Updates the state when there was an error loading the metadata
error = (state = null, action) ->
  switch action.type
    when ActionTypes.FETCH_CS
      if action.error then action.payload else null
    else state

# Combines together all the reducers related to category schemes
reducers =
  combineReducers {selectedCategory, categoryschemes, isFetching, error}

module.exports =
  categories: reducers
