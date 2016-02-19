React = require 'react'
dom = React.DOM
{CategoryScheme} = require '../categoryscheme/category-scheme.coffee'

Step = React.createClass
  render: ->
    opts =
      id: @props.categoryscheme.id
      name: @props.categoryscheme.name
      categories: @props.categoryscheme.categories
      onCategoryClick: @props.action
    dom.div {className: 'step-pane active sample-pane', 'data-step': '1'},
      React.createElement CategoryScheme, opts

Step.propTypes = {
  categoryscheme: React.PropTypes.object.isRequired,
  action: React.PropTypes.func.isRequired
}

exports.WizardStepOne = Step
