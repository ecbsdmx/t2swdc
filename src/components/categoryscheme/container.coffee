{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions.coffee'
{CategoryScheme} = require './category-scheme.coffee'

mapStateToProps = (state) ->
  results = state.categoryschemes.get(0)
  return {
    id: if results then state.categoryschemes.get(0).get('id') else "",
    name: if results then state.categoryschemes.get(0).get('name') else "",
    categories: if results then state.categoryschemes.get(0)?.
     get('categories').toJS() else []
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected(id)
  }

CategorySchemeContainer =
  connect(mapStateToProps, mapDispatchToProps)(CategoryScheme)

exports.csc = CategorySchemeContainer
