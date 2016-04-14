{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'
Immutable = require 'immutable'

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

# Updates the state when a user has selected a measure dimension
#
# @param [Number] the index of the current measure dimension
# @param [Object] the action received
#
# @return the new value for the selectedMeasure property if the action is of
# the expected type
#
selectedMeasure = (state = null, action) ->
  switch action.type
    when ActionTypes.SELECT_MEASURE then action.payload
    else return state

# Updates the state to indicate that the process to fetch data has started
isFetching = (state = false, action) ->
  switch action.type
    when ActionTypes.FETCH_DATA
      if not action.payload and not action.error then true else false
    else state

# Updates the state when the data have been loaded
#
# @param [Object] the current value for the data property
# @param [Object] the action received
#
# @return the new value for the data property if the action is of
# the expected type
#
data = (state = Immutable.Map({}), action) ->
  switch action.type
    when ActionTypes.FETCH_DATA
      if action.payload and not action.error
        Immutable.fromJS(action.payload)
      else state
    else state

reducers = combineReducers {selectedData, selectedMeasure, isFetching, data}

module.exports =
  filters: reducers
