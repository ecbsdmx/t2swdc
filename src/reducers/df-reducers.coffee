{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'

# Updates the state when a user has selected a dataflow
#
# @param [Object] the current value for the selectedDataflow property
# @param [Object] the action received
#
# @return the new value for the selectedDataflow property if the action is of
# the expected type
#
selectedDataflow = (state = null, action) ->
  switch action.type
    when ActionTypes.SELECT_DATAFLOW then action.payload
    else return state

reducers = combineReducers {selectedDataflow}

module.exports =
  dataflows: reducers
