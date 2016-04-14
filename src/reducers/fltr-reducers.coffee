{combineReducers} = require 'redux'
{ActionTypes} = require '../constants/action-types'
Immutable = require 'immutable'

# Updates the state when a user has selected data using the dimension filters
selectedData = (state = null, action) ->
  switch action.type
    when ActionTypes.SELECT_DATA then action.payload
    else return state

# Updates the state when a user has selected a measure dimension. The index of
# the current measure dimension will be passed
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
data = (state = Immutable.Map({}), action) ->
  switch action.type
    when ActionTypes.FETCH_DATA
      if action.payload and not action.error
        Immutable.fromJS(action.payload)
      else state
    else state

# Updates the state when there was an error loading the data
error = (state = null, action) ->
  switch action.type
    when ActionTypes.FETCH_DATA
      if action.error then action.payload else null
    else state

reducers =
  combineReducers {selectedData, selectedMeasure, isFetching, data, error}

module.exports =
  filters: reducers
