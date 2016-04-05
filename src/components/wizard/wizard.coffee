React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps').WizardSteps
Actions = require('./wizard-actions').WizardActions
StepOne = require('./wizard-step-1').WizardStepOne
StepTwo = require('./wizard-step-2').WizardStepTwo
StepThree = require('./wizard-step-3').WizardStepThree
data = require '../../../test/fixtures/ICP_PUB.json'

dimensions = data.structure.dimensions.series
series =  data.dataSets[0].series

Wizard = React.createClass
  stepChanged: (event, data) ->
    step = $('#wizard').wizard('selectedItem').step
    if step == 1 and not @props.selectedCategory \
    or step == 2 and not @props.selectedDataflow \
    or step == 3 and not @props.selectedFilters
      $('.btn-next').attr('disabled', 'disabled')
    else
      $('.btn-next').removeAttr('disabled')

  componentDidMount: ->
    if $? then $('#wizard').on('changed.fu.wizard', @stepChanged)

  render: ->
    step = if $? then $('#wizard').wizard('selectedItem').step else 1
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement Steps, {step: @props.selectedStep}
      React.createElement Actions,
        {step: @props.selectedStep, selectedCategory: @props.selectedCategory}
      dom.div {className: 'step-content'},
        React.createElement StepOne,
         {item: @props.categoryscheme, action: @props.onCategoryClick}
        React.createElement StepTwo,
         {items: @props.dataflows, action: @props.onDataflowClick}
        React.createElement StepThree,
         {dimensions: dimensions, series: series, step: step}

Wizard.propTypes =
  selectedStep: React.PropTypes.number.isRequired
  categoryscheme: React.PropTypes.object.isRequired
  onCategoryClick: React.PropTypes.func.isRequired
  selectedCategory: React.PropTypes.string
  dataflows: React.PropTypes.array.isRequired
  onDataflowClick: React.PropTypes.func.isRequired
  selectedFilters: React.PropTypes.object.isRequired

exports.Wizard = Wizard
