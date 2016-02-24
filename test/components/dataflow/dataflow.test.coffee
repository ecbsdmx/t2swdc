should = require('chai').should()
{Dataflow} = require '../../../src/components/dataflow/dataflow.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'Dataflow component', ->

  [id, name] = ['EXR', 'Exchange rates']

  it 'should render a dataflow as a bootstrap list group item', ->
    element = React.createElement Dataflow, {id: id, name: name}
    out = """
    <a id="df_#{id}" href="#" class="list-group-item">#{name}</a>
    """
    wrapper = shallow element
    wrapper.html().should.equal out
