should = require('chai').should()
{Category} = require '../../../src/components/categoryscheme/category.coffee'
React = require 'react'
{shallow} = require 'enzyme'
{categorySelected} = require '../../../src/actions/cs-actions.coffee'
sinon = require 'sinon'

describe 'Category component', ->

  [id, name, flowsNo, categoryClicked] = ['xyz', 'category', 3, sinon.spy()]

  it 'should render a category as a bootstrap list group item with badge', ->
    element = React.createElement Category,
      {id: id, name: name, numberOfFlows: flowsNo, onClick: categoryClicked}
    cat = """
    <a id="cat_#{id}" href="#" class="list-group-item">\
    <span class="badge badge-primary">#{flowsNo}</span>#{name}</a>
    """
    wrapper = shallow element
    wrapper.html().should.equal cat

  it 'should allow selecting a category', ->
    spy = sinon.spy()
    spy.withArgs id
    element = React.createElement Category,
      {id: id, name: name, numberOfFlows: flowsNo, onClick: spy}
    wrapper = shallow element
    wrapper.find('a').simulate 'click'
    spy.calledOnce.should.be.true
    spy.calledWithExactly(id).should.be.true
