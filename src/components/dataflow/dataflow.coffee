React = require 'react'
dom = React.DOM

Dataflow = React.createClass
  handleDataflowSelected: (ev) ->
    throw ReferenceError 'Expected onClick handler' unless @props.onClick
    @props.onClick @props.id

  render: ->
    dom.a(
      {id: "df_#{@props.id}", href: '#', className: 'list-group-item',
      onClick: @handleDataflowSelected},
      @props.name
    )

Dataflow.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  onClick: React.PropTypes.func.isRequired
}

exports.Dataflow = Dataflow
