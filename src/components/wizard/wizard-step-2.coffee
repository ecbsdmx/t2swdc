React = require 'react'
dom = React.DOM

Step = React.createClass
  render: ->
    dom.div {className: 'step-pane sample-pane', 'data-step': '2'},
      'Coming soon'

exports.WizardStepTwo = Step
