React = require 'react'
dom = React.DOM
{WizardSteps} = require('./wizard-steps.coffee')
{WizardStepOne} = require('./wizard-step-1.coffee')
{WizardStepTwo} = require('./wizard-step-2.coffee')
{WizardStepThree} = require('./wizard-step-3.coffee')
{WizardStepFour} = require('./wizard-step-4.coffee')

App = React.createClass
  render: ->
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement WizardSteps
      dom.div {className: 'step-content'},
        React.createElement WizardStepOne, {store: @props.store}
        React.createElement WizardStepTwo
        React.createElement WizardStepThree
        React.createElement WizardStepFour
exports.App = App
