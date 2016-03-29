React = require 'react'
dom = React.DOM
{Filters} = require '../filters/filters'

Step = React.createClass
  render: ->
    opts =
      dimensions: @props.dimensions
      series: @props.series
    dom.div {className: 'step-pane sample-pane', 'data-step': '3'},
      React.createElement Filters, opts

Step.propTypes = {
  dimensions: React.PropTypes.array.isRequired
  series: React.PropTypes.array.isRequired
}

exports.WizardStepThree = Step
