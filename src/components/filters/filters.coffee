React = require 'react'
dom = React.DOM
{Filter} = require './filter'
{MatchingSeries} = require './matching-series'
{MeasureInfo} = require './measure-info'
crossfilter = require 'crossfilter2'
Immutable = require 'immutable'

prevCheck = null
addPositions = (dimension) ->
  c.pos = idx for c, idx in dimension.values
  dimension

seriesKeyToObject = (item) ->
  object = {}
  object[idx] = v for v, idx in item.split(':')
  object

createFilters = (dimensions, seriesDim) ->
  (createFilter(i, seriesDim[idx]) for i, idx in dimensions)

createFilter = (dimension, smd) ->
  indices = (i.key for i in dimension.group().all() when i.value isnt 0)
  codes = (smd.values[i] for i in indices)
  {id: smd.id, name: smd.name, values: codes}

createSelectField = (d, idx) ->
  React.createElement Filter,
    {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values, pos: idx}

formatSelection = (item, field) ->
  $(field).parent().tooltip({title: item.text})
  item.text.substring(0, item.text.indexOf(' -'))

Filters = React.createClass

  universe: {}  # The crossfilter universe
  dims: []      # The crossfilter dimensions
  smd: []       # The SDMX series dimensions
  isInitial: false

  handleChanged: (ev) ->
    fieldNo = ev.currentTarget.id.replace('fltr_', '')
    values = $(ev.currentTarget).val()
    if values
      @dims[fieldNo].filterFunction (i) -> i in values
    else
      @dims[fieldNo].filterAll()
    @forceUpdate()

  handleCheckboxChanged: (ev) ->
    if prevCheck and prevCheck isnt ev.currentTarget
      $(prevCheck).prop('checked', false).change()
    prevCheck = ev.currentTarget

  componentWillUpdate: (nextProps, nextState) ->
    # When getting new data, we need to create crossfilter universe & dimensions
    if nextProps.series.equals? and not nextProps.series.equals?(@props.series)
      @universe = {}
      @dims = []
      @smd = []
      series = (seriesKeyToObject key for key of nextProps.series.toJS())
      @universe = crossfilter series
      @dims = []
      @dims.push @universe.dimension((d) -> d[k]) for k of series[0]
      @smd = (addPositions i for i in nextProps.dimensions.toJS())
      @isInitial = true

  componentDidUpdate: ->
    if @isInitial and $?
      $('select').select2({templateSelection: formatSelection})
      $('select').on('select2:select', @handleChanged)
      $('select').on('select2:unselect', @handleChanged)
      $('#filters :checkbox').bootstrapToggle()
      $('#filters :checkbox').change @handleCheckboxChanged

      @isInitial = false
    if $? # If there is only one value in the field, it should be selected
      $('select').each(() ->
        select = $(this)
        options = $(select).find 'option'
        if options.length is 1
          $(select).val($(options[0]).val()).trigger 'change'
      )

  render: ->
    if @props.busy
      dom.div {id: 'loading', className: 'text-center'},
        dom.span {className: 'glyphicon glyphicon-repeat gly-spin'}
    else if @props.error
      dom.div {className: 'alert alert-danger'}, @props.error.message
    else if @universe.hasOwnProperty 'groupAll'
      filters = createFilters @dims, @smd
      nodes = (createSelectField(d, idx) for d, idx in filters)
      dom.div (id: 'filters'),
        React.createElement MeasureInfo, {}
        React.createElement MatchingSeries,
          {number: @universe.groupAll().value()}
        dom.form {id: 'dimensionFilters'}, nodes
    else false

Filters.propTypes = {
  dimensions: React.PropTypes.instanceOf(Immutable.List).isRequired
  series: React.PropTypes.instanceOf(Immutable.Map).isRequired
}

exports.Filters = Filters
