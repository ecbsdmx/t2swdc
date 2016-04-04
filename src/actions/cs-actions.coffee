{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types'

# Creates an action indicating that the user has selected a category
#
# @param [String] urn the SDMX urn of the selected category
#
categorySelected = (urn) ->
  unless typeof urn is 'string' and urn.trim().length > 0
    throw TypeError 'The category id must be a non-empty string'
  createAction(ActionTypes.SELECT_CATEGORY)(urn)

# Validates the category schemes array
#
# @param cs the category schemes to be validated
#
# @return true if all category schemes are OK, false otherwise
validItems = (cs) ->
  if cs.length is 0 then return false
  valid = true
  for item in cs
    valid = if not item.categories then false else valid
  valid

# Creates an action indicating that the process to load the category schemes is
# finished
#
# @param [Object] cs the category scheme object
#
csLoaded = (cs) ->
  unless cs instanceof Error or cs instanceof Array and validItems cs
    throw TypeError 'The parameter must be a category scheme array'
  createAction(ActionTypes.FETCH_CS_SUCCESS)(cs)

# Creates an action indicating that the process to load the category schemes has
# started
#
csLoading = ->
  createAction(ActionTypes.FETCH_CS)()

module.exports =
  categorySelected: categorySelected
  csLoaded: csLoaded
  csLoading: csLoading
