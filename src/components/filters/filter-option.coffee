React = require 'react'
dom = React.DOM

FilterOption = React.createClass
  render: ->
    dom.option {value: @props.pos}, "#{@props.id} - #{@props.name}"

FilterOption.propTypes = {
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
  pos: React.PropTypes.number.isRequired
}

exports.FilterOption = FilterOption
