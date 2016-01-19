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

# Creates an action indicating that the process to load the category schemes is
# finished
#
# @param [Object] cs the category scheme object
#
csLoaded = (cs) ->
  if not cs or cs not instanceof Error and
    not cs.categoryschemes or cs.categoryschemes?.length is 0
      throw TypeError 'The parameter must be a category scheme object'
  createAction(ActionTypes.CS_LOADED)(cs)

module.exports =
  categorySelected: categorySelected
  csLoaded: csLoaded
