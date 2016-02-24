React = require 'react'
dom = React.DOM
{Dataflow} = require './dataflow.coffee'

Dataflows = React.createClass
  render: ->
    nodes = @props.dataflows?.map (i) ->
      React.createElement Dataflow, {key: i.id, id: i.id, name: i.name}
    dom.div {id: "dataflows", className: 'list-group'}, nodes

Dataflows.propTypes = {
  dataflows: React.PropTypes.array.isRequired
}

exports.Dataflows = Dataflows
