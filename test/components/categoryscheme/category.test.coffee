assert = require('chai').assert
{Category} = require '../../../src/components/categoryscheme/category.coffee'
React = require 'react'
{shallow} = require 'enzyme'
sinon = require 'sinon'
chai = require 'chai'
sinonChai = require 'sinon-chai'

chai.should()
chai.use sinonChai

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
    spy.should.have.been.calledOnce
    spy.should.have.been.calledWithExactly id

  it 'should handle the case where there is no on click handler', ->
    element = React.createElement Category,
      {id: id, name: name, numberOfFlows: flowsNo}
    wrapper = shallow element
    try
      wrapper.find('a').simulate 'click'
      assert.fail 'A ReferenceError should have been triggered'
    catch error
