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

module.exports =
  dataSelected: dataSelected
