React = require 'react'
dom = React.DOM

FilterOption = React.createClass
  render: -> dom.option {id: @props.id}, @props.name

FilterOption.propTypes = {
  id: React.PropTypes.string.isRequired
  name: React.PropTypes.string.isRequired
}

exports.FilterOption = FilterOption
