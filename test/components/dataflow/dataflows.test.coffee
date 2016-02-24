should = require('chai').should()
{Dataflows} = require '../../../src/components/dataflow/dataflows.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'Dataflows component', ->

  flows = [
    {id:'EXR', name:'Exchange rates'},
    {id:'BP6', name:'Balance of Payments'},
  ]

  it 'should render dataflows as a bootstrap list group div', ->
    out = """
    <div id="dataflows" class="list-group">\
    <a id="df_EXR" href="#" class="list-group-item">Exchange rates</a>\
    <a id="df_BP6" href="#" class="list-group-item">Balance of Payments</a>\
    </div>
    """
    element = React.createElement Dataflows, {dataflows: flows}
    wrapper = shallow element
    wrapper.html().should.equal out
