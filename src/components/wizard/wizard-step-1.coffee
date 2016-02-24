React = require 'react'
dom = React.DOM
{CategoryScheme} = require '../categoryscheme/category-scheme.coffee'

Step = React.createClass
  render: ->
    opts =
      id: @props.item.id
      name: @props.item.name
      categories: @props.item.categories
      onCategoryClick: @props.action
    dom.div {className: 'step-pane active sample-pane', 'data-step': '1'},
      React.createElement CategoryScheme, opts

Step.propTypes = {
  item: React.PropTypes.object.isRequired,
  action: React.PropTypes.func.isRequired
}

exports.WizardStepOne = Step
