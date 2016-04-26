React = require 'react'
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
span = React.DOM.span

createItem = (idx, step, label) ->
  opts =
    'data-step': idx
    'data-name': label.replace(' ', '').toLowerCase()
    'key': idx
  if step == idx then opts.className = 'active'
  li opts,
    span {className: 'badge'}, idx
    label,
    span {className: 'chevron'}

Steps = React.createClass
  render: ->
    div {className: 'steps-container'},
      ul {className: 'steps'},
        createItem ++idx, @props.step, label\
          for label, idx in ['Topics', 'Data sets', 'Filters']

Steps.propTypes =
  step: React.PropTypes.number.isRequired

exports.WizardSteps = Steps
