React = require 'react'
dom = React.DOM

Step = React.createClass
  render: ->
    dom.div {className: 'step-pane sample-pane', 'data-step': '4'},
      'Coming soon'

exports.WizardStepFour = Step
