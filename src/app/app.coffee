React = require 'react'
dom = React.DOM
{csc} = require('../components/categoryscheme/container.coffee')

App = React.createClass
  render: ->
    dom.div {id: 'app'}, React.createElement csc, {store: @props.store}

exports.App = App
