{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types'
fetch = require 'isomorphic-fetch'
sdmxrest = require 'sdmx-rest'

# Creates an action indicating that the user has selected the data he is
# interested in using dimension filters.
#
# @param [String] a url representing an SDMX 2.1 data query
#
dataSelected = (url) ->
  unless typeof url is 'string' and url.trim().length > 0
    throw TypeError 'The input must be an SDMX 2.1 data query url'
  createAction(ActionTypes.SELECT_DATA)(url)

# Creates an action indicating that the user has selected a dimension to be used
# as measure dimension in Tableau
#
# @param [Number] the position of the dimension to be used as measure dimension
#
measureSelected = (idx) ->
  throw TypeError 'The input must be an integer indicating the position of
    the dimension' if idx? and typeof idx isnt 'number'
  createAction(ActionTypes.SELECT_MEASURE)(idx)

# Creates an action indicating that the process to load data is finished
#
# @param [Object] data the SDMX-JSON data object
#
dataLoaded = (data) ->
  unless data instanceof Error or data instanceof Object \
  and not Array.isArray data
    throw TypeError 'The parameter must be an SDMX-JSON data message'
  createAction(ActionTypes.FETCH_DATA)(data)

# Creates an action indicating that the process to load data has started
#
dataLoading = ->
  createAction(ActionTypes.FETCH_DATA)()

# Async action to fetch data
fetchData = (url) ->
  (dispatch) ->
    dispatch dataLoading()
    sdmxrest.request(url,{headers:{accept:sdmxrest.data.DataFormat.SDMX_JSON}})
      .then((response) -> dispatch dataLoaded(JSON.parse response))
      .catch((error) -> dispatch dataLoaded(error))

module.exports =
  dataSelected: dataSelected
  measureSelected: measureSelected
  dataLoading: dataLoading
  dataLoaded: dataLoaded
  fetchData: fetchData
