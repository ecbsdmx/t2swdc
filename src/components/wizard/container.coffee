{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions'
{dataflowSelected} = require '../../actions/df-actions'
{fetchData} = require '../../actions/fltr-actions'
{dataSelected, measureSelected} = require '../../actions/fltr-actions'
{Wizard} = require './wizard'
sdmxrest = require 'sdmx-rest'

findAttachedFlows = (state) ->
  categoryscheme = state.categories.categoryschemes.get(0).toJS()
  out = category.dataflows \
    for category in categoryscheme.categories \
    when category.id is state.categories.selectedCategory
  return out

mapStateToProps = (state) ->
  results = state.categories.categoryschemes.get(0)
  return {
    categoryscheme:
      id: results?.get('id') ? ''
      name: results?.get('name') ? ''
      categories: results?.get('categories')?.toJS() ? []
    selectedCategory: state.categories.selectedCategory
    selectedDataflow: state.dataflows?.selectedDataflow
    dataflows:
      if state.categories.selectedCategory then findAttachedFlows state else []
    selectedFilters: {}
    data: state.filters?.data
    error: state.filters?.error
    isFetching: state.filters.isFetching
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected id
      if $? then $('#wizard').wizard 'next'
    onDataflowClick: (id) ->
      dispatch dataflowSelected id
      if $? then $('#wizard').wizard 'next'
      query =
        flow: id
        detail: sdmxrest.data.DataDetail.SERIES_KEYS_ONLY
      url = sdmxrest.getUrl query, 'ECB_S'
      dispatch fetchData url
    onImportClick: (url, index) ->
      dispatch dataSelected url
      dispatch measureSelected index
  }

WizardContainer =
  connect(mapStateToProps, mapDispatchToProps)(Wizard)

exports.WizardContainer = WizardContainer
