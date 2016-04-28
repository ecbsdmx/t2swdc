React = require 'react'
dom = React.DOM

MatchingSeries = React.createClass
  render: ->
    dom.div {id: 'MatchingSeries', className: 'row'},
      dom.div {className: 'col-sm-6 col-md-7 col-lg-8'},
        dom.strong {className: 'h4'}, @props.name
      dom.div { className: 'text-right col-sm-6 col-md-5 col-lg-4'},
        dom.strong {className: 'h4'}, @props?.number?.toLocaleString() ? 0
        ' series matching your selection'

MatchingSeries.propTypes =
  number: React.PropTypes.number.isRequired
  name: React.PropTypes.string.isRequired

exports.MatchingSeries = MatchingSeries
