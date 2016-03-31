React = require 'react'
dom = React.DOM
{Filter} = require './filter.coffee'
crossfilter = require 'crossfilter2'

seriesKeyToObject = (item) ->
  object = {}
  object[idx] = v for v, idx in item.split(':')
  object

createFilters = (dimensions, seriesDim) ->
  (createFilter(i, seriesDim[idx]) for i, idx in dimensions)

createFilter = (dimension, smd) ->
  indices = (i.key for i in dimension.group().all() when i.value isnt 0)
  codes = (smd.values[i] for i in indices)
  filter =
    id: smd.id
    name: smd.name
    values: codes
  filter

createSelectField = (d, idx) ->
  React.createElement Filter,
      {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values, pos: idx}

Filters = React.createClass

  universe: {}
  dims: []

  handleChanged: (ev) ->
    fieldId = ev.currentTarget.id
    fieldNo = fieldId.replace('fltr_', '')
    values = $(ev.currentTarget).val()
    if values
      @dims[fieldNo].filterFunction (i) -> i in values
    else
      @dims[fieldNo].filterAll()
    @forceUpdate()

  componentWillUpdate: (nextProps, nextState) ->
    if not @universe.hasOwnProperty 'groupAll'
      series = (seriesKeyToObject key for key of nextProps.series)
      @universe = crossfilter series
      @dims.push @universe.dimension((d) -> d[k]) for k of series[0]

  componentDidUpdate: ->
    if $? then $('select').select2()
    if $? then $('select').on('select2:select', @handleChanged)
    if $? then $('select').on('select2:unselect', @handleChanged)

  render: ->
    if @universe.hasOwnProperty 'groupAll'
      filters = createFilters @dims, @props.dimensions
      nodes = (createSelectField(d, idx) for d, idx in filters)
      dom.div (id: 'filters'),
        dom.div {className: 'bg-info text-right'},
          "#{@universe.groupAll().value()} series matching your query."
        dom.form {id: 'dimensionFilters'}, nodes
    else false

Filters.propTypes = {
  dimensions: React.PropTypes.array.isRequired
  series: React.PropTypes.object.isRequired
}

exports.Filters = Filters
