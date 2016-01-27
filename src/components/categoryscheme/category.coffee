React = require 'react'
dom = React.DOM

exports.Category = React.createClass
  render: ->
    dom.a(
      {id: "cat_#{@props.id}", href: "#", className: "list-group-item"},
      dom.span({className: "badge badge-primary"}, @props.numberOfFlows),
      @props.name
    )
