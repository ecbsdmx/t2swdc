React = require 'react'
{createStore} = require 'redux'
categories = require('../../src/reducers/cs-reducers.coffee').categories
wizard = require('../../src/reducers/wiz-reducers.coffee').wizard
{combineReducers} = require 'redux'
should = require('chai').should()
{shallow} = require 'enzyme'
csActions = require '../../src/actions/cs-actions.coffee'
{WizardStepOne} = require '../../src/app/wizard-step-1.coffee'

describe 'Wizard step 1 component', ->

  it 'should have the expected categoryscheme container', ->
    [id, name] = ['abcd', 'category scheme']
    cats = [
      {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
      {id:'B', name:'catB', dataflows:[]},
    ]
    payload = [{id: id, name: name, categories: cats}]
    reducers = combineReducers {categories, wizard}
    store = createStore reducers
    store.dispatch csActions.csLoaded payload
    step  = React.createElement WizardStepOne, {store: store}
    wrapper = shallow step
    scheme = """
    <div class="step-pane active sample-pane" \
    data-step="1"><div id="cs_abcd" class="list-group"><a id="cat_A" href="#" \
    class="list-group-item"><span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item"><span class="badge \
    badge-primary">0</span>catB</a></div></div>
    """
    wrapper.html().should.equal scheme
