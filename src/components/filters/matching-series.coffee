React = require 'react'
dom = React.DOM

MatchingSeries = React.createClass
  render: ->
    dom.div {id: 'MatchingSeries',
    className: 'bg-info text-right no-top-margin'},
        dom.strong {className: 'h4'}, @props?.number?.toLocaleString() ? 0
        ' series matching your query'

MatchingSeries.propTypes =
  number: React.PropTypes.number.isRequired

exports.MatchingSeries = MatchingSeries
