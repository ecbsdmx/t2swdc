{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types.coffee'

# Creates an action indicating that the user has selected a category
#
# @param [String] urn the SDMX urn of the selected category
#
categorySelected = (urn) ->
  if not urn or typeof urn isnt 'string' or urn.trim().length is 0
    throw TypeError 'The category id must be a non-empty string'
  createAction(ActionTypes.CATEGORY_SELECTED)(urn)

# Validates the category schemes array
#
# @param cs the category schemes to be validated
#
# @return true if all category schemes are OK, false otherwise
validItems = (cs) ->
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
  if not cs or cs not instanceof Error and
    cs not instanceof Array or cs.length is 0 or not validItems cs
      throw TypeError 'The parameter must be a category scheme array'

  createAction(ActionTypes.CS_LOADED)(cs)

module.exports =
  categorySelected: categorySelected
  csLoaded: csLoaded
