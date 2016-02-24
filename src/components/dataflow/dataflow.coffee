React = require 'react'
dom = React.DOM

Dataflow = React.createClass
  render: ->
    dom.a(
      {id: "df_#{@props.id}", href: '#', className: 'list-group-item'},
      @props.name
    )

Dataflow.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired
}

exports.Dataflow = Dataflow
