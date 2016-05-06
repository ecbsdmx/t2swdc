React = require 'react'
dom = React.DOM
Steps = require('./wizard-steps').WizardSteps
Actions = require('./wizard-actions').WizardActions
StepOne = require('./wizard-step-1').WizardStepOne
StepTwo = require('./wizard-step-2').WizardStepTwo
StepThree = require('./wizard-step-3').WizardStepThree
sdmxrest = require 'sdmx-rest'

getStep = () ->
  return if $? then $('#wizard').wizard('selectedItem').step else 1

Wizard = React.createClass
  displayName: "Wizard"
  handleImport: () ->
    throw ReferenceError 'Expected import handler' unless @props.onImportClick
    filters = []
    dims = @props.data?.get('structure')?.get('dimensions').get('series').toJS()
    $('select').each((idx, ele) ->
      if $(ele).val()
        filters.push (dims[idx].values[pos].id for pos in $(ele).val())
      else filters.push []
    )
    url = sdmxrest.getUrl {flow: @props.selectedDataflow, key: filters}, 'ECB_S'
    index = null
    $('#filters button').each () ->
      sel = $(this).val() is 'selected'
      index = $(this).attr('id').replace('meas_', '') if sel
    @props.onImportClick url, parseInt(index)

  stepChanged: (event, data) ->
    step = getStep()
    $('.btn-next').attr('disabled', true) if $?

  componentDidMount: ->
    if $?
      $('#wizard').on('changed.fu.wizard', @stepChanged)
      $('#wizard').on('finished.fu.wizard', @handleImport)

  render: ->
    step = getStep()
    dom.div {className: 'wizard', 'data-initialize': 'wizard', id: 'wizard'},
      React.createElement Steps
      React.createElement Actions
      dom.div {className: 'step-content'},
        React.createElement StepOne,
         {item: @props.categoryscheme, action: @props.onCategoryClick,
         error: @props.smdError, busy: @props.isFetchingSmd}
        React.createElement StepTwo,
         {items: @props.dataflows, action: @props.onDataflowClick,
         selectedDataflow: @props.selectedDataflow}
        React.createElement StepThree,
         {data: @props.data, step: step, error: @props.dataError,
         busy: @props.isFetchingData, hierarchies: @props.hierarchies}

Wizard.propTypes =
  categoryscheme: React.PropTypes.object.isRequired
  selectedCategory: React.PropTypes.string
  dataflows: React.PropTypes.array.isRequired
  selectedDataflow: React.PropTypes.string.isRequired
  selectedFilters: React.PropTypes.object.isRequired
  data: React.PropTypes.object.isRequired
  onCategoryClick: React.PropTypes.func.isRequired
  onDataflowClick: React.PropTypes.func.isRequired
  onImportClick: React.PropTypes.func.isRequired
  dataError: React.PropTypes.object.isRequired
  smdError: React.PropTypes.object.isRequired
  isFetchingData: React.PropTypes.bool.isRequired
  isFetchingSmd: React.PropTypes.bool.isRequired
  hierarchies: React.PropTypes.object.isRequired

exports.Wizard = Wizard
