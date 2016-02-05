React = require 'react'
dom = React.DOM

Category = React.createClass
  render: ->
    dom.a(
      {id: "cat_#{@props.id}", href: '#', className: 'list-group-item'},
      dom.span({className: 'badge badge-primary'}, @props.numberOfFlows),
      @props.name
    )

Category.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  numberOfFlows: React.PropTypes.number.isRequired
}

exports.Category = Category
