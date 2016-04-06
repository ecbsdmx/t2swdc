{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types'

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

module.exports =
  dataSelected: dataSelected
  measureSelected: measureSelected
