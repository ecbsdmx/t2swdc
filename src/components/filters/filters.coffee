React = require 'react'
dom = React.DOM
{Filter} = require './filter'
{MatchingSeries} = require './matching-series'
{MeasureInfo} = require './measure-info'
crossfilter = require 'crossfilter2'

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
    $('#filters input:checkbox:checked').each () ->
      if $(this).val() isnt $(ev.currentTarget).val()
        $(this).attr('checked', false)

  componentWillUpdate: (nextProps, nextState) ->
    # When getting new data, we need to create crossfilter universe & dimensions
    if 'groupAll' not of @universe or nextProps.series isnt @props.series
      @universe = {}
      @dims = []
      @smd = []
      series = (seriesKeyToObject key for key of nextProps.series)
      @universe = crossfilter series
      @dims = []
      @dims.push @universe.dimension((d) -> d[k]) for k of series[0]
      @smd = (addPositions i for i in nextProps.dimensions)
      @isInitial = true

  componentDidUpdate: ->
    if @isInitial and $?
      $('select').select2({templateSelection: formatSelection})
      $('select').on('select2:select', @handleChanged)
      $('select').on('select2:unselect', @handleChanged)
      $('#filters :checkbox').bootstrapToggle()
      $('#filters :checkbox').click @handleCheckboxChanged

      @isInitial = false
    if $? # If there is only one value in the field, it should be selected
      $('select').each(() ->
        select = $(this)
        options = $(select).find 'option'
        if options.length is 1
          $(select).val($(options[0]).val()).trigger 'change'
      )

  render: ->
    if @universe.hasOwnProperty 'groupAll'
      filters = createFilters @dims, @smd
      nodes = (createSelectField(d, idx) for d, idx in filters)
      dom.div (id: 'filters'),
        React.createElement MeasureInfo, {}
        React.createElement MatchingSeries,
          {number: @universe.groupAll().value()}
        dom.form {id: 'dimensionFilters'}, nodes
    else false

Filters.propTypes = {
  dimensions: React.PropTypes.array.isRequired
  series: React.PropTypes.object.isRequired
}

exports.Filters = Filters
