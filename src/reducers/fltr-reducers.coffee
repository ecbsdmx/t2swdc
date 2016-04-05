{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'

# Updates the state when a user has selected data using the dimension filters
#
# @param [String] the current value for the selectedData property
# @param [Object] the action received
#
# @return the new value for the selectedData property if the action is of
# the expected type
#
selectedData = (state = null, action) ->
  switch action.type
    when ActionTypes.SELECT_DATA then action.payload
    else return state

reducers = combineReducers {selectedData}

module.exports =
  filters: reducers
