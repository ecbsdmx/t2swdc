React = require 'react'
dom = React.DOM
{FilterOption} = require './filter-option.coffee'

createNode = (i) ->
  React.createElement FilterOption,
    {key: i.id, id: i.id, name: i.name, pos: i.pos}

Filter = React.createClass
  render: ->
    sorted = @props.values?.sort (a, b) ->
      if a.id < b.id then -1 else 1
    options = (createNode v for v in sorted when v)
    id = "fltr_#{@props.pos}"
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
  pos: React.PropTypes.number.isRequired
}

exports.Filter = Filter
