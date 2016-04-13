React = require 'react'
dom = React.DOM
{Filters} = require '../filters/filters'

Step = React.createClass
  render: ->
    opts =
      dimensions: @props?.data?.structure?.dimensions.series ? []
      series: @props?.data?.dataSets?[0].series ? {}
    dom.div {className: 'step-pane sample-pane', 'data-step': '3'},
      React.createElement Filters, opts

  shouldComponentUpdate: (nextProps, nextState) ->
    nextProps.step is 3

Step.propTypes = {
  data: React.PropTypes.object.isRequired
  step: React.PropTypes.number.isRequired
}

exports.WizardStepThree = Step
