React = require 'react'
dom = React.DOM
{Filter} = require './filter.coffee'

Filters = React.createClass
  render: ->
    filters = @props.dimensions?.map (d) ->
      React.createElement Filter,
        {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values}
    dom.form {id: 'dimensionFilters'}, filters

Filters.propTypes = {
  dimensions: React.PropTypes.array.isRequired
  series: React.PropTypes.array.isRequired
}

exports.Filters = Filters
