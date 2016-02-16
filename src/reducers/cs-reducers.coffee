{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types.coffee'
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
    when ActionTypes.CATEGORY_SELECTED then action.payload
    else return state

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
    when ActionTypes.CS_LOADED then Immutable.fromJS(action.payload)
    else return state

# Combines together all the reducers related to category schemes
reducers = combineReducers {selectedCategory, categoryschemes}

module.exports =
  categories: reducers
