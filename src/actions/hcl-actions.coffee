{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types'
sdmxrest = require 'sdmx-rest'
sdmxmllib = require 'sdmxmllib'

getId = (urn) ->
  urn.substring(urn.lastIndexOf('.') + 1)

handleH = (h) ->
  out = { 'mu': [], 'nmu': []}
  for i in h.items
    codeId = getId i.code.href
    if codeId is 'EA'
      out.mu = (getId c.code.href for c in i.items)
    else if codeId is 'NEA'
      out.nmu = (getId c.code.href for c in i.items)
  out

# Validates the country hierarchies object
validHierarchy = (hcl) ->
  hcl.mu.length > 0 and hcl.nmu.length > 0

# Creates an action indicating that the process to load the hierarchies is
# finished
hclLoaded = (hcl) ->
  unless hcl instanceof Error or hcl instanceof Object and validHierarchy hcl
    throw TypeError 'The parameter must be a countries hierarchy object'
  createAction(ActionTypes.FETCH_HCL)(hcl)

# Creates an action indicating that the process to load the hierarchies has
# started
hclLoading = ->
  createAction(ActionTypes.FETCH_HCL)()

# Async action to fetch the countries hierarchical codelist
fetchHCL = (url) ->
  (dispatch) ->
    dispatch hclLoading()
    sdmxrest.request(url)
      .then((response) ->
        str = sdmxmllib.mapSDMXMLResponse response
        items = str.resources[0].items
        hcl = (handleH h for h in items when h.id is 'EU_GROUPINGS_PROTOCOL')
        dispatch hclLoaded hcl[0])
      .catch((error) -> dispatch hclLoaded error)

module.exports =
  hclLoaded: hclLoaded
  hclLoading: hclLoading
  fetchHCL: fetchHCL
