{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions'
{dataflowSelected} = require '../../actions/df-actions'
{fetchData} = require '../../actions/fltr-actions'
{dataSelected, measureSelected} = require '../../actions/fltr-actions'
{Wizard} = require './wizard'
sdmxrest = require 'sdmx-rest'

findAttachedFlows = (cs, selCat) ->
  return cat.dataflows for cat in cs.categories when cat.id is selCat

mapStateToProps = (state) ->
  cs = state.categories.categoryschemes.get(0)?.toJS()
  selCat = state.categories.selectedCategory
  return {
    categoryscheme:
      id: cs?.id ? ''
      name: cs?.name ? ''
      categories: cs?.categories ? []
    selectedCategory: selCat
    selectedDataflow: state.dataflows?.selectedDataflow
    dataflows:
      if selCat then findAttachedFlows(cs, selCat) else []
    selectedFilters: {}
    data: state.filters?.data
    smdError: state.categories?.error
    dataError: state.filters?.error
    isFetchingData: state.filters.isFetching
    isFetchingSmd: state.categories.isFetching
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected id
      if $? then $('#wizard').wizard 'next'
    onDataflowClick: (id, hasChanged) ->
      if hasChanged
        dispatch dataflowSelected id
        query =
          flow: id
          detail: sdmxrest.data.DataDetail.SERIES_KEYS_ONLY
        url = sdmxrest.getUrl query, 'ECB_S'
        dispatch fetchData url
      if $? then $('#wizard').wizard 'next'
    onImportClick: (url, index) ->
      dispatch dataSelected url
      dispatch measureSelected index
  }

WizardContainer =
  connect(mapStateToProps, mapDispatchToProps)(Wizard)

exports.WizardContainer = WizardContainer
