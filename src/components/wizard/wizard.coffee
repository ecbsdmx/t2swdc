React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps').WizardSteps
Actions = require('./wizard-actions').WizardActions
StepOne = require('./wizard-step-1').WizardStepOne
StepTwo = require('./wizard-step-2').WizardStepTwo
StepThree = require('./wizard-step-3').WizardStepThree
data = require '../../../test/fixtures/SAFE.json'

dimensions = data.structure.dimensions.series
series =  data.dataSets[0].series
getStep = () ->
  return if $? then $('#wizard').wizard('selectedItem').step ? 1 else 1

Wizard = React.createClass
  stepChanged: (event, data) ->
    step = getStep()
    if step is 1 and not @props.selectedCategory \
    or step is 2 and not @props.selectedDataflow
      $('.btn-next').attr('disabled', 'disabled')
    else
      $('.btn-next').removeAttr('disabled')

  componentDidMount: ->
    if $? then $('#wizard').on('changed.fu.wizard', @stepChanged)

  render: ->
    step = getStep()
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement Steps, {step: step}
      React.createElement Actions
      dom.div {className: 'step-content'},
        React.createElement StepOne,
         {item: @props.categoryscheme, action: @props.onCategoryClick}
        React.createElement StepTwo,
         {items: @props.dataflows, action: @props.onDataflowClick}
        React.createElement StepThree,
         {dimensions: dimensions, series: series, step: step}

Wizard.propTypes =
  categoryscheme: React.PropTypes.object.isRequired
  onCategoryClick: React.PropTypes.func.isRequired
  selectedCategory: React.PropTypes.string
  dataflows: React.PropTypes.array.isRequired
  onDataflowClick: React.PropTypes.func.isRequired
  selectedFilters: React.PropTypes.object.isRequired

exports.Wizard = Wizard
