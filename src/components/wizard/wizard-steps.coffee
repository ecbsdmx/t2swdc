React = require 'react'
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
span = React.DOM.span

createItem = (idx, label) ->
  opts =
    'data-step': idx
    'data-name': label.replace(' ', '').toLowerCase()
    'key': idx
  if idx is 1 then opts.className = 'active'
  li opts,
    span {className: 'badge'}, idx
    label,
    span {className: 'chevron'}

Steps = React.createClass
  shouldComponentUpdate: (nextProps, nextState) ->
    false
  render: ->
    div {className: 'steps-container'},
      ul {className: 'steps'},
        createItem ++idx, label\
          for label, idx in ['Topics', 'Data sets', 'Filters']

exports.WizardSteps = Steps
