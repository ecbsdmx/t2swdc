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

createSelectField = (d) ->
  React.createElement Filter,
      {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values}

Filters = React.createClass

  universe: undefined
  dims: []

  componentWillUpdate: (nextProps, nextState) ->
    console.log 'In Filters Will Update'
    series = (seriesKeyToObject key for key of nextProps.series)
    @universe = crossfilter series
    @dims.push @universe.dimension((d) -> d[k]) for k of series[0]

  componentDidUpdate: ->
    if $? then $('select').select2()

  render: ->
    if @universe
      console.log 'In Filters Render'
      filters = createFilters @dims, @props.dimensions
      nodes = (createSelectField d for d in filters)
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
