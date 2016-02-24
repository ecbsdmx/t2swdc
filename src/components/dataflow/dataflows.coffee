React = require 'react'
dom = React.DOM
{Dataflow} = require './dataflow.coffee'

Dataflows = React.createClass
  render: ->
    action = @props.onDataflowClick
    nodes = @props.dataflows?.map (i) ->
      React.createElement Dataflow,
        {key: i.id, id: i.id, name: i.name, onClick: action}
    dom.div {id: "dataflows", className: 'list-group'}, nodes

Dataflows.propTypes = {
  dataflows: React.PropTypes.array.isRequired,
  onDataflowClick: React.PropTypes.func.isRequired
}

exports.Dataflows = Dataflows
