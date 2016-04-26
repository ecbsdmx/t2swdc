React = require 'react'
should = require('chai').should()
{shallow} = require 'enzyme'
{WizardStepOne} = require '../../../src/components/wizard/wizard-step-1.coffee'

describe 'Wizard step 1 component', ->

  it 'should have the expected categoryscheme container', ->
    [id, name] = ['abcd', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    scheme = {id: id, name: name, categories: cats}
    onCategoryClick = (id) ->
      console.log id
    step  = React.createElement WizardStepOne,
      {item: scheme, action: onCategoryClick}
    wrapper = shallow step
    scheme = """
    <div class="step-pane active sample-pane" \
    data-step="1"><div id="cs_abcd" class="list-group"><a id="cat_A" href="#" \
    class="list-group-item"><span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item"><span class="badge \
    badge-primary">0</span>catB</a></div></div>
    """
    wrapper.html().should.equal scheme
