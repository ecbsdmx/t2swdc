should = require('chai').should()
{MeasureInfo} = require '../../../src/components/filters/measure-info'
React = require 'react'
{shallow} = require 'enzyme'

describe 'MatchingSeries component', ->

  it 'should render the measure info box a bootstrap alert', ->
    element = React.createElement MeasureInfo, {}
    out = """
    <div class="bg-info alert alert-info alert-dismissible fade in">\
    <button type="button" class="close" data-dismiss="alert">\
    <span>×</span></button>\
    <div>Please <strong>select the data</strong> you are interested in <strong>using the filters below</strong>. \
    If you want to import <strong>all the data</strong> into Tableau, simply <strong>press the button</strong> above.<br/><br/></div>\
    <div>Tableau allows you to easily compare <strong>multiple measures</strong>. Should you wish \
    to use the values of a dimension as measures in Tableau, please <strong>use the \
    switch</strong> next to the filter for that dimension.</div>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out
