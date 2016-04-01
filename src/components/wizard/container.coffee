{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions'
{wizstepChanged} = require '../../actions/wiz-actions'
{dataflowSelected} = require '../../actions/df-actions'
{Wizard} = require './wizard'

findAttachedFlows = (state) ->
  categoryscheme = state.categories.categoryschemes.get(0).toJS()
  out = category.dataflows \
    for category in categoryscheme.categories \
    when category.id is state.categories.selectedCategory
  return out

mapStateToProps = (state) ->
  results = state.categories.categoryschemes.get(0)
  return {
    selectedStep: state.wizard.selectedStep
    categoryscheme:
      id: results?.get('id') ? ''
      name: results?.get('name') ? ''
      categories: results?.get('categories')?.toJS() ? []
    selectedCategory: state.categories.selectedCategory
    selectedDataflow: state.dataflows?.selectedDataflow
    dataflows:
      if state.categories.selectedCategory then findAttachedFlows state else []
    selectedFilters: {}
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected id
      dispatch wizstepChanged 2
      if $? then $('#wizard').wizard 'next'
    onDataflowClick: (id) ->
      dispatch dataflowSelected id
      dispatch wizstepChanged 3
      if $? then $('#wizard').wizard 'next'
  }

WizardContainer =
  connect(mapStateToProps, mapDispatchToProps)(Wizard)

exports.wizContainer = WizardContainer
