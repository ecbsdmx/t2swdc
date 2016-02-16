{connect} = require 'react-redux'
{categorySelected} = require '../../actions/cs-actions.coffee'
{CategoryScheme} = require './category-scheme.coffee'

mapStateToProps = (state) ->
  results = state.categories.categoryschemes.get(0)
  return {
    id: results?.get('id') ? '',
    name: results?.get('name') ? '',
    categories: results?.get('categories')?.toJS() ? []
  }

mapDispatchToProps = (dispatch) ->
  return {
    onCategoryClick: (id) ->
      dispatch categorySelected(id)
  }

CategorySchemeContainer =
  connect(mapStateToProps, mapDispatchToProps)(CategoryScheme)

exports.csc = CategorySchemeContainer
