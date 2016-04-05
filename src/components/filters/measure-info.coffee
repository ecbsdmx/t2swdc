React = require 'react'
dom = React.DOM

firstItem = () ->
  return { __html: 'Please <strong>select the data</strong> you are
   interested in <strong>using the filters below</strong>. If you want to
   import <strong>all the data</strong> into Tableau, simply <strong>press the
   button</strong> above.<br/><br/>'}

secondItem = () ->
  return { __html: 'Tableau allows you to easily compare <strong>multiple
   measures</strong>. Should you wish to use the values of a dimension as
   measures in Tableau, please <strong>use the switch</strong> next to the
   filter for that dimension.'}

MeasureInfo = React.createClass
  render: ->
    dom.div {className:'bg-info alert alert-info alert-dismissible fade in'},
      dom.button {type:'button', className:'close', 'data-dismiss':'alert'},
        dom.span {}, '×'
      dom.div {dangerouslySetInnerHTML: firstItem()}
      dom.div {dangerouslySetInnerHTML: secondItem()}

exports.MeasureInfo = MeasureInfo
