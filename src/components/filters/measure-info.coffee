React = require 'react'
dom = React.DOM

MeasureInfo = React.createClass
  render: ->
    dom.div {className:'bg-info alert alert-info alert-dismissible fade in'},
      dom.button {type:'button', className:'close', 'data-dismiss':'alert'},
        dom.span {}, '×'
      dom.p {}, 'Please select the data you are interested in using the
       filters below. If you want to import all the data into Tableau, simply
       press the button above.'
      dom.p {}, 'Tableau allows you to easily compare multiple measures. Should
       you wish to use the values of a dimension as measures in Tableau, please
       use the switch next to the filter for that dimension.'

exports.MeasureInfo = MeasureInfo
