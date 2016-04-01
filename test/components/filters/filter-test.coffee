should = require('chai').should()
{Filter} = require '../../../src/components/filters/filter.coffee'
React = require 'react'
{shallow} = require 'enzyme'
jsdom = require 'mocha-jsdom'

describe 'Filter component', ->

  values = [
    {id: 'A', name: 'Annual'}
    {id: 'D', name: 'Daily'}
  ]
  [i, n, v] = ['FREQ', 'Frequency', values]

  singleValue = [
    {id: 'A', name: 'Annual'}
  ]

  # Unsorted
  u = [
    {id: 'D', name: 'Daily'}
    {id: 'A', name: 'Annual'}
  ]

  it 'should render a dimension filter as a select field', ->
    element = React.createElement Filter, {id: i, name: n, values: v, pos: 0}
    out = """
    <div class="form-group">\
    <label for="fltr_0">#{n} (2)</label>\
    <select id="fltr_0" class="form-control select2" multiple="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-close-on-select="false" \
    data-theme="bootstrap">\
    <option>#{v[0].id} - #{v[0].name}</option>\
    <option>#{v[1].id} - #{v[1].name}</option>\
    </select>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should disable selection in case only one value is available', ->
    element = React.createElement Filter,
      {id: i, name: n, values: singleValue, pos: 0}
    out = """
    <div class="form-group">\
    <label for="fltr_0">#{n} (1)</label>\
    <select id="fltr_0" class="form-control select2" multiple="" \
    disabled="" data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-close-on-select="false" \
    data-theme="bootstrap">\
    <option>#{v[0].id} - #{v[0].name}</option>\
    </select>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out

  it 'should sort by code ids', ->
    element = React.createElement Filter, {id: i, name: n, values: u, pos: 0}
    out = """
    <div class="form-group">\
    <label for="fltr_0">#{n} (2)</label>\
    <select id="fltr_0" class="form-control select2" multiple="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-close-on-select="false" \
    data-theme="bootstrap">\
    <option>#{u[1].id} - #{u[1].name}</option>\
    <option>#{u[0].id} - #{u[0].name}</option>\
    </select>\
    </div>
    """
    wrapper = shallow element
    wrapper.html().should.equal out
