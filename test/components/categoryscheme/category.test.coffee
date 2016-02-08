should = require('chai').should()
assert = require('chai').assert
{Category} = require '../../../src/components/categoryscheme/category.coffee'
React = require 'react'
{shallow, mount} = require 'enzyme'
{categorySelected} = require '../../../src/actions/cs-actions.coffee'
sinon = require 'sinon'
jsdom = require 'mocha-jsdom'

describe 'Category component', ->

  jsdom()

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

  it 'should handle the case where there is no on click handler', ->
    element = React.createElement Category,
      {id: id, name: name, numberOfFlows: flowsNo}
    wrapper = mount element
    try
      wrapper.find('a').simulate 'click'
      assert.fail 'A ReferenceError should have been triggered'
    catch error
