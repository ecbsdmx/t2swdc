should = require('chai').should()
{MatchingSeries} = require '../../../src/components/filters/matching-series'
React = require 'react'
{shallow} = require 'enzyme'

describe 'MatchingSeries component', ->

  it 'should render the number of matching series as a bootstrap div', ->
    element = React.createElement MatchingSeries, {number: 10}
    out = "<div id=\"MatchingSeries\" class=\"text-right no-top-margin\"><strong class=\"h4\">10</strong> series matching your selection</div>"
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should handle the absence of number as 0', ->
    element = React.createElement MatchingSeries, {}
    out = "<div id=\"MatchingSeries\" class=\"text-right no-top-margin\"><strong class=\"h4\">0</strong> series matching your selection</div>"
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should format the number of series to be displayed', ->
    element = React.createElement MatchingSeries, {number: 61118}
    out = "<div id=\"MatchingSeries\" class=\"text-right no-top-margin\"><strong class=\"h4\">61,118</strong> series matching your selection</div>"
    wrapper = shallow element
    wrapper.html().should.equal out
