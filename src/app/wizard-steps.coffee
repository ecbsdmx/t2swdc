React = require 'react'
dom = React.DOM

Steps = React.createClass
  render: ->
    dom.div {className: 'steps-container'},
      dom.ul {className: 'steps'},
        dom.li {className: 'active', 'data-step': 1, 'data-name': 'topics'},
          dom.span {className: 'badge'}, 1
          'Topics'
          dom.span {className: 'chevron'}
        dom.li {'data-step': 2, 'data-name': 'datasets'},
          dom.span {className: 'badge'}, 2
          'Data sets'
          dom.span {className: 'chevron'}
        dom.li {'data-step': 3, 'data-name': 'filters'},
          dom.span {className: 'badge'}, 3
          'Filters'
          dom.span {className: 'chevron'}
        dom.li {'data-step': 4, 'data-name': 'options'},
          dom.span {className: 'badge'}, 4
          'Options'
          dom.span {className: 'chevron'}

exports.WizardSteps = Steps
