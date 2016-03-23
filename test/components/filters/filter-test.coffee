should = require('chai').should()
{Filter} = require '../../../src/components/filters/filter.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'Filter component', ->

  values = [
    {id: 'A', name: 'Annual'}
    {id: 'D', name: 'Daily'}
  ]
  [i, n, v] = ['FREQ', 'Frequency', values]

  singleValue = [
    {id: 'A', name: 'Annual'}
  ]

  it 'should render a dimension filter as a select field', ->
    element = React.createElement Filter, {id: i, name: n, values: v}
    out = """
    <div class="form-group">\
    <label for="fltr_#{i}">#{n} (2)</label>\
    <select id="fltr_#{i}" class="form-control" multiple="" data-placeholder=\
    "Select an item or start typing to search" data-allow-clear="true" \
    data-select-on-close="true" data-close-on-select="false">\
    <option id=\"#{v[0].id}\">#{v[0].name}</option>\
    <option id=\"#{v[1].id}\">#{v[1].name}</option>\
    </select>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should disable selection in case only one value is available', ->
    element = React.createElement Filter, {id: i, name: n, values: singleValue}
    out = """
    <div class="form-group">\
    <label for="fltr_#{i}">#{n} (1)</label>\
    <select id="fltr_#{i}" class="form-control" multiple="" disabled="" \
     data-placeholder="Select an item or start typing to search" \
     data-allow-clear="true" \
     data-select-on-close="true" data-close-on-select="false">\
    <option id=\"#{v[0].id}\">#{v[0].name}</option>\
    </select>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out
