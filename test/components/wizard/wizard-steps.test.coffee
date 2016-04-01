React = require 'react'
should = require('chai').should()
{shallow} = require 'enzyme'
{WizardSteps} = require '../../../src/components/wizard/wizard-steps'

describe 'Wizard steps component', ->

  it 'should have the expected 4 steps', ->
    wrapper = shallow React.createElement WizardSteps, {step: 2}
    output = """
    <div class="steps-container">\
    <ul class="steps">\
    <li data-step="1" data-name="topics">\
    <span class="badge">1</span>Topics<span class="chevron"></span></li>\
    <li data-step="2" data-name="datasets" class="active">\
    <span class="badge">2</span>Data sets<span class="chevron"></span></li>\
    <li data-step="3" data-name="filters"><span class="badge">3</span>Filters\
    <span class="chevron"></span></li>\
    <li data-step="4" data-name="options">\
    <span class="badge">4</span>Options<span class="chevron"></span></li></ul>\
    </div>
    """
    wrapper.html().should.equal output
