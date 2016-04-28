React = require 'react'
dom = React.DOM
{Dataflow} = require './dataflow'

arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> elem.id is b[i].id

Dataflows = React.createClass

  handleDataflowSelected: (id) ->
    hasChanged = id isnt @props.selectedDataflow
    @props.onDataflowClick id, hasChanged

  shouldComponentUpdate: (nextProps, nextState) ->
    not arrayEqual nextProps.dataflows, @props.dataflows
  render: ->
    action = @handleDataflowSelected
    nodes = @props.dataflows?.map (i) ->
      React.createElement Dataflow,
        {key: i.id, id: i.id, name: i.name, onClick: action}
    dom.div {id: "dataflows", className: 'list-group'}, nodes

Dataflows.propTypes =
  dataflows: React.PropTypes.array.isRequired
  onDataflowClick: React.PropTypes.func.isRequired
  selectedDataflow: React.PropTypes.string.isRequired

exports.Dataflows = Dataflows
