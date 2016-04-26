React = require 'react'
dom = React.DOM
{Category} = require './category'

CategoryScheme = React.createClass
  render: ->
    if @props.busy
      dom.div {id: 'loading', className: 'text-center'},
        dom.span {className: 'glyphicon glyphicon-repeat gly-spin'}
    else if @props.error
      dom.div {className: 'alert alert-danger'}, @props.error.message
    else
      action = @props.onCategoryClick
      categoryNodes = @props.categories?.map (c) ->
        React.createElement Category,
          {key: c.id, id: c.id, name: c.name, numberOfFlows: c.dataflows.length,
          onClick: action}
      dom.div {id: "cs_#{@props.id}", className: 'list-group'},
        categoryNodes

CategoryScheme.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  categories: React.PropTypes.array.isRequired,
  onCategoryClick: React.PropTypes.func.isRequired
}

exports.CategoryScheme = CategoryScheme
