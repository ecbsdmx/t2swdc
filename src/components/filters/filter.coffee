React = require 'react'
dom = React.DOM
{FilterOption} = require './filter-option.coffee'

Filter = React.createClass
  render: ->
    sorted = @props.values?.sort (a, b) ->
      val = 0
      if a.id < b.id then val = -1
      else if a.id > b.id then val = 1
      val
    options = sorted.map (v) ->
      React.createElement FilterOption, {key: v.id, id: v.id, name: v.name}
    id = "fltr_#{@props.id}"
    size = @props.values?.length ? 0
    dom.div {className: 'form-group'},
      dom.label {htmlFor: id}, "#{@props.name} (#{size})"
      dom.select {id: id, className: 'form-control select2', multiple: true,
      disabled: @props.values?.length is 1 ? false,
      'data-placeholder': 'Select an item or start typing to search',
      'data-allow-clear': true, 'data-close-on-select': false,
      'data-theme': 'bootstrap'}, options

Filter.propTypes = {
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
  values: React.PropTypes.array.isRequired
}

exports.Filter = Filter
