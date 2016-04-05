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
    <p>Please select the data you are interested in using the filters below. \
    If you want to import all the data into Tableau, simply press the button above.</p>\
    <p>Tableau allows you to easily compare multiple measures. Should you wish \
    to use the values of a dimension as measures in Tableau, please use the \
    switch next to the filter for that dimension.</p>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out
