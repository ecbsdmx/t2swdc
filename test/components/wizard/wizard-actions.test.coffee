React = require 'react'
should = require('chai').should()
{shallow} = require 'enzyme'
{WizardActions} = require '../../../src/components/wizard/wizard-actions.coffee'

describe 'Wizard actions component', ->

  it 'should have the expected 2 actions', ->
    wrapper = shallow React.createElement WizardActions,
      {step: 1, selectedCategory: 'a'}
    output = """\
    <div class="actions">\
    <button type="button" class="btn btn-default btn-next" disabled="">\
    Import into Tableau\
    </button></div>\
    """
    wrapper.html().should.equal output
