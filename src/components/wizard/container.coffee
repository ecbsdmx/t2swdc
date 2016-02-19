{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions.coffee'
{wizstepChanged} = require '../../actions/wiz-actions.coffee'
{Wizard} = require './wizard.coffee'

mapStateToProps = (state) ->
  results = state.categories.categoryschemes.get(0)
  return {
    selectedStep: state.wizard.selectedStep,
    categoryscheme: {
      id: results?.get('id') ? '',
      name: results?.get('name') ? '',
      categories: results?.get('categories')?.toJS() ? []
    }
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected id
      dispatch wizstepChanged 2
  }

WizardContainer =
  connect(mapStateToProps, mapDispatchToProps)(Wizard)

exports.wizContainer = WizardContainer
