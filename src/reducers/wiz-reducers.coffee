{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'

# Updates the state when the step displayed in the wizard need to be changed
#
# @param [Object] the current value for the selectedStep property
# @param [Object] the action received
#
# @return the new value for the selectedStep property if the action is of
# the expected type
#
selectedStep = (state = 1, action) ->
  switch action.type
    when ActionTypes.CHANGE_WIZSTEP then action.payload
    else return state

# Combines together all the reducers related to the wizard
reducers = combineReducers {selectedStep}

module.exports =
  wizard: reducers
