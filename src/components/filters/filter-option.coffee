React = require 'react'
dom = React.DOM

cntryGrps = ['0EU', '0MU', '0NMU']

FilterOption = React.createClass
  render: ->
    if @props.id in cntryGrps
      dom.option {value: @props.id}, "#{@props.name}"
    else
      dom.option {value: @props.pos}, "#{@props.id} - #{@props.name}"

FilterOption.propTypes =
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
  pos: React.PropTypes.number.isRequired

exports.FilterOption = FilterOption
