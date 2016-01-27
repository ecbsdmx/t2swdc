should = require('chai').should()
expect = require('chai').expect
{Category} = require '../../../src/components/categoryscheme/category.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'Category component', ->
  it 'should render a category as a bootstrap list group item with badge', ->
    id = 'xyz'
    name = 'category'
    flowsNo = 3
    cat = """
    <a id=\"cat_#{id}\" href=\"#\" class=\"list-group-item\">\
    <span class=\"badge badge-primary\">#{flowsNo}</span>\
    #{name}</a>
    """
    element =
      React.createElement Category, {id: id, name: name, numberOfFlows: flowsNo}
    wrapper = shallow element
    html = wrapper.html()
    expect(html).to.equal cat
