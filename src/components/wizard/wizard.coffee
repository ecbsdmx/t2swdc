React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps.coffee').WizardSteps
StepOne = require('./wizard-step-1.coffee').WizardStepOne
StepTwo = require('./wizard-step-2.coffee').WizardStepTwo
StepThree = require('./wizard-step-3.coffee').WizardStepThree
StepFour = require('./wizard-step-4.coffee').WizardStepFour

Wizard = React.createClass
  render: ->
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement Steps,
        {step: @props.selectedStep}
      dom.div {className: 'step-content'},
        React.createElement StepOne,
         {categoryscheme: @props.categoryscheme, action: @props.onCategoryClick}
        React.createElement StepTwo
        React.createElement StepThree
        React.createElement StepFour

Wizard.propTypes = {
  selectedStep: React.PropTypes.number.isRequired,
  categoryscheme: React.PropTypes.object.isRequired,
  onCategoryClick: React.PropTypes.func.isRequired
}

exports.Wizard = Wizard
