React = require 'react'
dom = React.DOM
{csc} = require('../categoryscheme/container.coffee')

Step = React.createClass
  render: ->
    dom.div {className: 'step-pane active sample-pane', 'data-step': '1'},
      React.createElement csc, {store: @props.store}

exports.WizardStepOne = Step
