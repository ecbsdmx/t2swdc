React = require 'react'
dom = React.DOM
Wizard = require('../components/wizard/container.coffee').wizContainer

App = React.createClass
  render: ->
    React.createElement Wizard, {store: @props.store}

exports.App = App
