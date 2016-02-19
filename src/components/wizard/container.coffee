{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions.coffee'
{wizstepChanged} = require '../../actions/wiz-actions.coffee'
{Wizard} = require './wizard.coffee'

mapStateToProps = (state) ->
  results = state.categories.categoryschemes.get(0)
  return {
    selectedStep: state.wizard.selectedStep
    categoryscheme:
      id: results?.get('id') ? ''
      name: results?.get('name') ? ''
      categories: results?.get('categories')?.toJS() ? []
    selectedCategory: state.categories.selectedCategory
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected id
      dispatch wizstepChanged 2
      if $? then $('#wizard').wizard 'next'
  }

WizardContainer =
  connect(mapStateToProps, mapDispatchToProps)(Wizard)

exports.wizContainer = WizardContainer
