{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types.coffee'

# Creates an action indicating that the user has selected a dataflow
#
# @param [String] id the dataflow identifier
#
dataflowSelected = (id) ->
  unless typeof id is 'string' and id.trim().length > 0
    throw TypeError 'The dataflow id must be a non-empty string'
  createAction(ActionTypes.SELECT_DATAFLOW)(id)

module.exports =
  dataflowSelected: dataflowSelected
