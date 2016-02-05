React = require 'react'
dom = React.DOM
{categorySelected} = require '../../actions/cs-actions.coffee'

Category = React.createClass
  handleTodoSelected: (ev) ->
    throw TypeError 'Expected onClick handler' unless @props.onClick
    @props.onClick @props.id

  render: ->
    dom.a(
      {id: "cat_#{@props.id}", href: '#', className: 'list-group-item',
      onClick: @handleTodoSelected},
      dom.span({className: 'badge badge-primary'}, @props.numberOfFlows),
      @props.name
    )

Category.propTypes = {
  id: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  numberOfFlows: React.PropTypes.number.isRequired
  onClick: React.PropTypes.func.isRequired
}

exports.Category = Category
