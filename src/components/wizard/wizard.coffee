React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps.coffee').WizardSteps
Actions = require('./wizard-actions.coffee').WizardActions
StepOne = require('./wizard-step-1.coffee').WizardStepOne
StepTwo = require('./wizard-step-2.coffee').WizardStepTwo
StepThree = require('./wizard-step-3.coffee').WizardStepThree
StepFour = require('./wizard-step-4.coffee').WizardStepFour

Wizard = React.createClass
  stepChanged: (event, data) ->
    step = $('#wizard').wizard('selectedItem').step
    if step == 1 and not @props.selectedCategory \
    or step == 2 and not @props.selectedDataflow
      $('.btn-next').attr('disabled', 'disabled')
    else
      $('.btn-next').removeAttr('disabled')

  componentDidMount: ->
    if $? then $('#wizard').on('changed.fu.wizard', @stepChanged)

  render: ->
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement Steps, {step: @props.selectedStep}
      React.createElement Actions,
        {step: @props.selectedStep, selectedCategory: @props.selectedCategory}
      dom.div {className: 'step-content'},
        React.createElement StepOne,
         {categoryscheme: @props.categoryscheme, action: @props.onCategoryClick}
        React.createElement StepTwo
        React.createElement StepThree
        React.createElement StepFour

Wizard.propTypes =
  selectedStep: React.PropTypes.number.isRequired
  categoryscheme: React.PropTypes.object.isRequired
  onCategoryClick: React.PropTypes.func.isRequired
  selectedCategory: React.PropTypes.string

exports.Wizard = Wizard
