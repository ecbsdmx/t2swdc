{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types'
fetch = require 'isomorphic-fetch'
sdmxrest = require 'sdmx-rest'
{sdmxmllib} = require 'sdmxmllib'

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
  createAction(ActionTypes.FETCH_CS)(cs)

# Creates an action indicating that the process to load the category schemes has
# started
#
csLoading = ->
  createAction(ActionTypes.FETCH_CS)()

# Async action to fetch a category scheme
fetchCS = (url) ->
  (dispatch) ->
    dispatch csLoading()
    sdmxrest.request(url)
      .then((response) ->
        str = sdmxmllib.mapSDMXMLResponse response
        schemes = []
        for key of str.resources
          artefact = str.resources[key]
          if artefact.class is 'CategoryScheme'
            artefact.categories = artefact.items
            for cat in artefact.categories
              cat.dataflows = cat.children
            schemes.push artefact
                
        dispatch csLoaded schemes)
      .catch((error) -> dispatch csLoaded error)

module.exports =
  categorySelected: categorySelected
  csLoaded: csLoaded
  csLoading: csLoading
  fetchCS: fetchCS
