should = require('chai').should()
{FilterOption} = require '../../../src/components/filters/filter-option.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'FilterOption component', ->

  [id, name] = ['A', 'Annual']

  it 'should render a dimension value used in a filter as a select option', ->
    element = React.createElement FilterOption, {id: id, name: name, pos: 0}
    out = "<option value=\"0\">#{id} - #{name}</option>"
    wrapper = shallow element
    wrapper.html().should.equal out
