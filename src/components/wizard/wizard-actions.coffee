React = require 'react'
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
span = React.DOM.span
button = React.DOM.button

Actions = React.createClass
  shouldComponentUpdate: (nextProps, nextState) ->
    false
  render: ->
    btnOpts =
      type: 'button'
      className: 'btn btn-default btn-next'
      'disabled': true
    div {className: 'actions'},
      button btnOpts, 'Import into Tableau'

exports.WizardActions = Actions
