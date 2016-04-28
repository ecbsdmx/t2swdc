React = require 'react'
dom = React.DOM
{Dataflows} = require '../dataflow/dataflows'

Step = React.createClass
  render: ->
    opts =
      dataflows: @props.items
      onDataflowClick: @props.action
      selectedDataflow: @props.selectedDataflow
    dom.div {className: 'step-pane sample-pane', 'data-step': '2'},
      React.createElement Dataflows, opts

Step.propTypes =
  items: React.PropTypes.array.isRequired
  action: React.PropTypes.func.isRequired
  selectedDataflow: React.PropTypes.string.isRequired

exports.WizardStepTwo = Step
