should = require('chai').should()
{MatchingSeries} = require '../../../src/components/filters/matching-series'
React = require 'react'
{shallow} = require 'enzyme'

describe 'MatchingSeries component', ->

  it 'should render the number of matching series as a bootstrap div', ->
    element = React.createElement MatchingSeries, {name: 'test', number: 10}
    out = "<div id=\"MatchingSeries\" class=\"row\"><div class=\"col-sm-6 col-md-7 col-lg-8\"><strong class=\"h4\">test</strong></div><div class=\"text-right col-sm-6 col-md-5 col-lg-4\"><strong class=\"h4\">10</strong> series matching your selection</div></div>"
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should handle the absence of number as 0', ->
    element = React.createElement MatchingSeries, {name: 'test'}
    out = "<div id=\"MatchingSeries\" class=\"row\"><div class=\"col-sm-6 col-md-7 col-lg-8\"><strong class=\"h4\">test</strong></div><div class=\"text-right col-sm-6 col-md-5 col-lg-4\"><strong class=\"h4\">0</strong> series matching your selection</div></div>"
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should format the number of series to be displayed', ->
    element = React.createElement MatchingSeries, {number: 61118, name: 'test'}
    out = "<div id=\"MatchingSeries\" class=\"row\"><div class=\"col-sm-6 col-md-7 col-lg-8\"><strong class=\"h4\">test</strong></div><div class=\"text-right col-sm-6 col-md-5 col-lg-4\"><strong class=\"h4\">61,118</strong> series matching your selection</div></div>"
    wrapper = shallow element
    wrapper.html().should.equal out
