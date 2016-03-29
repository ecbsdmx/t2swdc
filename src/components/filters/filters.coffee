React = require 'react'
dom = React.DOM
{Filter} = require './filter.coffee'

Filters = React.createClass
  componentDidUpdate: ->
    if $? then $('select').select2()
  render: ->
    filters = @props.dimensions?.map (d) ->
      React.createElement Filter,
        {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values}
    dom.div (id: 'filters'),
      dom.div {className: 'bg-info text-right'},
        "#{@props.series.length} series matching your query."
      dom.form {id: 'dimensionFilters'}, filters

Filters.propTypes = {
  dimensions: React.PropTypes.array.isRequired
  series: React.PropTypes.array.isRequired
}

exports.Filters = Filters
