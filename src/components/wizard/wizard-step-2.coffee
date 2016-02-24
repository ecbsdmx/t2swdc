React = require 'react'
dom = React.DOM
{Dataflows} = require '../dataflow/dataflows.coffee'

Step = React.createClass
  render: ->
    opts =
      dataflows: @props.items
      onDataflowClick: @props.action
    dom.div {className: 'step-pane sample-pane', 'data-step': '2'},
      React.createElement Dataflows, opts

Step.propTypes = {
  items: React.PropTypes.array.isRequired,
  action: React.PropTypes.func.isRequired
}

exports.WizardStepTwo = Step
