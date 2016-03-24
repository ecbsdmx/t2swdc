React = require 'react'
dom = React.DOM
{FilterOption} = require './filter-option.coffee'

Filter = React.createClass
  render: ->
    options = @props.values?.map (v) ->
      React.createElement FilterOption, {key: v.id, id: v.id, name: v.name}
    id = "fltr_#{@props.id}"
    size = @props.values?.length ? 0
    dom.div {className: 'form-group'},
      dom.label {htmlFor: id}, "#{@props.name} (#{size})"
      dom.select {id: id, className: 'form-control', multiple: true,
      disabled: @props.values?.length is 1 ? false,
      'data-placeholder': 'Select an item or start typing to search',
      'data-allow-clear': true, 'data-select-on-close': true,
      'data-close-on-select': false}, options

Filter.propTypes = {
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
  values: React.PropTypes.array.isRequired
}

exports.Filter = Filter
