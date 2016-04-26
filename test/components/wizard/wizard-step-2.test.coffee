React = require 'react'
should = require('chai').should()
{shallow} = require 'enzyme'
{WizardStepTwo} = require '../../../src/components/wizard/wizard-step-2'

describe 'Wizard step 2 component', ->

  it 'should have the expected dataflows container', ->
    flows = [
      {id:'EXR', name:'Exchange rates'},
      {id:'BP6', name:'Balance of Payments'},
    ]
    onClick = (id) -> console.log id
    step  = React.createElement WizardStepTwo, {items: flows, action: onClick}
    wrapper = shallow step
    scheme = """
    <div class="step-pane sample-pane" data-step="2">\
    <div id="dataflows" class="list-group">\
    <a id="df_EXR" href="#" class="list-group-item">Exchange rates</a>\
    <a id="df_BP6" href="#" class="list-group-item">Balance of Payments</a>\
    </div></div>
    """
    wrapper.html().should.equal scheme
