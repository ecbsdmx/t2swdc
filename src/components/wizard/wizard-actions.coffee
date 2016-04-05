React = require 'react'
div = React.DOM.div
ul = React.DOM.ul
li = React.DOM.li
span = React.DOM.span
button = React.DOM.button

createButton = (isNext) ->
  btnOpts =
    type: 'button'
    className: 'btn btn-default ' + if isNext then 'btn-next' else 'btn-prev'
  if isNext
    btnOpts['data-last'] = 'Send to Tableau'
    btnOpts['disabled'] = true

  spanOpts =
    className: 'glyphicon ' \
      + if isNext then 'glyphicon-arrow-right' else 'glyphicon-arrow-left'

  button btnOpts,
    span spanOpts


Actions = React.createClass
  render: ->
    div {className: 'actions'},
      createButton false
      createButton true

Actions.propTypes =
  step: React.PropTypes.number.isRequired,
  selectedCategory: React.PropTypes.string,
  selectedDataflow: React.PropTypes.string,
  selectedFilters: React.PropTypes.array

exports.WizardActions = Actions
