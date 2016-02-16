React = require 'react'
dom = React.DOM
{WizardSteps} = require('../components/wizard/wizard-steps.coffee')
{WizardStepOne} = require('../components/wizard/wizard-step-1.coffee')
{WizardStepTwo} = require('../components/wizard/wizard-step-2.coffee')
{WizardStepThree} = require('../components/wizard/wizard-step-3.coffee')
{WizardStepFour} = require('../components/wizard/wizard-step-4.coffee')

App = React.createClass
  render: ->
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement WizardSteps,
        {step: @props.store.getState().wizard.selectedStep}
      dom.div {className: 'step-content'},
        React.createElement WizardStepOne, {store: @props.store}
        React.createElement WizardStepTwo
        React.createElement WizardStepThree
        React.createElement WizardStepFour
exports.App = App
