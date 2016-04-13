React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps').WizardSteps
Actions = require('./wizard-actions').WizardActions
StepOne = require('./wizard-step-1').WizardStepOne
StepTwo = require('./wizard-step-2').WizardStepTwo
StepThree = require('./wizard-step-3').WizardStepThree
sdmxrest = require 'sdmx-rest'

getStep = () ->
  return if $? then $('#wizard').wizard('selectedItem').step ? 1 else 1

Wizard = React.createClass

  handleImport: () ->
    throw ReferenceError 'Expected import handler' unless @props.onImportClick
    filters = []
    $('select').each((idx, ele) ->
      if $(ele).val()
        filters.push (dimensions[idx].values[pos].id for pos in $(ele).val())
      else filters.push []
    )
    url = sdmxrest.getUrl {flow: @props.selectedDataflow, key: filters}, 'ECB_S'
    index = null
    $('#filters input:checkbox:checked').each () ->
      index = $(this).val()
    @props.onImportClick url, parseInt(index)

  stepChanged: (event, data) ->
    step = getStep()
    if step is 1 and not @props.selectedCategory \
    or step is 2 and not @props.selectedDataflow
      $('.btn-next').attr('disabled', 'disabled')
    else
      $('.btn-next').removeAttr('disabled')

  componentDidMount: ->
    if $?
      $('#wizard').on('changed.fu.wizard', @stepChanged)
      $('#wizard').on('finished.fu.wizard', @handleImport)

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
        React.createElement StepThree, {data: @props.data, step: step}

Wizard.propTypes =
  categoryscheme: React.PropTypes.object.isRequired
  selectedCategory: React.PropTypes.string
  dataflows: React.PropTypes.array.isRequired
  selectedFilters: React.PropTypes.object.isRequired
  data: React.PropTypes.object.isRequired
  onCategoryClick: React.PropTypes.func.isRequired
  onDataflowClick: React.PropTypes.func.isRequired
  onImportClick: React.PropTypes.func.isRequired

exports.Wizard = Wizard
