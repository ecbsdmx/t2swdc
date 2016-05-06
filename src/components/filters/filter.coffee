React = require 'react'
dom = React.DOM
{FilterOption} = require './filter-option'

createNode = (i) ->
  React.createElement FilterOption,
    {key: i.id, id: i.id, name: i.name, pos: i.pos}

Filter = React.createClass
  render: ->
    sorted = @props.values?.concat()
    sorted.sort (a, b) ->
      if a.id < b.id then -1 else 1
    codes = (createNode v for v in sorted when v)
    id = "fltr_#{@props.pos}"
    size = @props.values?.length ? 0
    opts =
      id: id
      className: 'form-control select2'
      multiple: true
      disabled: size is 1 ? false
      'data-placeholder': 'Select an item or start typing to search'
      'data-allow-clear': true
      'data-close-on-select': false
      'data-theme': 'bootstrap'
    dom.div {className: 'form-group'},
      dom.label {htmlFor: id, className:'control-label col-sm-3'},
        "#{@props.name} (#{size})"
      dom.div {className: 'col-sm-8 input-group'},
        dom.select opts, codes
        dom.span {className: 'input-group-btn'},
          dom.button {className: 'btn btn-default', type:'button', \
            id: "meas_#{@props.pos}"}, 'As measure'

Filter.propTypes = {
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
  values: React.PropTypes.array.isRequired
  pos: React.PropTypes.number.isRequired
}

exports.Filter = Filter
