React = require 'react'
dom = React.DOM
{Category} = require './category.coffee'

CategoryScheme = React.createClass
  render: ->
    categoryNodes = @props.categories.map (c) ->
      React.createElement Category,
        {key: c.id, id: c.id, name: c.name, numberOfFlows: c.dataflows.length}
    dom.div {id: "cs_#{@props.id}", className:"list-group"},
      categoryNodes

CategoryScheme.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  categories: React.PropTypes.array.isRequired
}

exports.CategoryScheme = CategoryScheme
