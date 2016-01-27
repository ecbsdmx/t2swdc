chai = require 'chai'
spies = require 'chai-spies'
chai.use spies
should = chai.should()
expect = chai.expect
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

  it 'should have a mandatory string id', ->
    name = 'category'
    flowsNo = 3
    spy = chai.spy.on console, 'error'
    React.createElement Category, {name: name, numberOfFlows: flowsNo}
    React.createElement Category, {id: 3, name: name, numberOfFlows: flowsNo}
    expect(spy).to.have.been.called.exactly(2)

  it 'should have a mandatory string name', ->
    id = 'category'
    flowsNo = 3
    spy = chai.spy.on console, 'error'
    React.createElement Category, {id: id, numberOfFlows: flowsNo}
    React.createElement Category, {id: id, name: 3, numberOfFlows: flowsNo}
    expect(spy).to.have.been.called.exactly(2)

  it 'should have a mandatory number of flows', ->
    id = 'id'
    name = 'category'
    spy = chai.spy.on console, 'error'
    React.createElement Category, {id: id, name: name}
    React.createElement Category, {id: id, name: name, numberOfFlows: "6"}
    expect(spy).to.have.been.called.exactly(2)
