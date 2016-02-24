should = require('chai').should()
assert = require('chai').assert
{Dataflow} = require '../../../src/components/dataflow/dataflow.coffee'
React = require 'react'
{shallow, mount} = require 'enzyme'
sinon = require 'sinon'
jsdom = require 'mocha-jsdom'

describe 'Dataflow component', ->

  jsdom()

  [id, name] = ['EXR', 'Exchange rates']

  it 'should render a dataflow as a bootstrap list group item', ->
    element = React.createElement Dataflow, {id: id, name: name}
    out = """
    <a id="df_#{id}" href="#" class="list-group-item">#{name}</a>
    """
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should allow selecting a dataflow', ->
    spy = sinon.spy()
    spy.withArgs id
    element = React.createElement Dataflow, {id: id, name: name, onClick: spy}
    wrapper = shallow element
    wrapper.find('a').simulate 'click'
    spy.calledOnce.should.be.true
    spy.calledWithExactly(id).should.be.true

  it 'should handle the case where there is no on click handler', ->
    element = React.createElement Dataflow, {id: id, name: name}
    wrapper = mount element
    try
      wrapper.find('a').simulate 'click'
      assert.fail 'A ReferenceError should have been triggered'
    catch error
