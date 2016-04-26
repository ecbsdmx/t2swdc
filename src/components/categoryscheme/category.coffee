React = require 'react'
dom = React.DOM

Category = React.createClass
  handleCategorySelected: (ev) ->
    throw ReferenceError 'Expected onClick handler' unless @props.onClick
    @props.onClick @props.id

  render: ->
    dom.a(
      {id: "cat_#{@props.id}", href: '#', className: 'list-group-item',
      onClick: @handleCategorySelected},
      dom.span({className: 'badge badge-primary'}, @props.numberOfFlows),
      @props.name
    )

Category.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  numberOfFlows: React.PropTypes.number.isRequired
  onClick: React.PropTypes.func.isRequired
}

exports.Category = Category
