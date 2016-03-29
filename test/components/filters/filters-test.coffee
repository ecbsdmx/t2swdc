should = require('chai').should()
{Filters} = require '../../../src/components/filters/filters.coffee'
React = require 'react'
{mount} = require 'enzyme'
jsdom = require 'mocha-jsdom'

createOption = (v) ->
  "<option id=\"#{v.id}\">#{v.id} - #{v.name}</option>"

createSelect = (d) ->
  out = """
  <div class="form-group">\
  <label for="fltr_#{d.id}">#{d.name} (#{d.values.length})</label>\
  <select id="fltr_#{d.id}" class="form-control select2" multiple=""
  """
  if d.values.length is 1
    out += ' disabled=""'
  out += """
   data-placeholder="Select an item or start typing to search" \
  data-allow-clear="true" data-close-on-select="false" data-theme="bootstrap">\
  """
  out += createOption v for v in d.values
  out += "</select></div>"
  out

describe 'Filters component', ->

  jsdom()

  s = ['A.NOK.EUR.SP00', 'A.CHF.EUR.SP00']
  d = [
    {id: 'FREQ', name: 'Frequency', values: [{id: 'A', name: 'Annual'}]}
    {id: 'CURRENCY', name: 'Currency', values: [{id: 'CHF', name: 'Swiss Franc'}, {id: 'NOK', name: 'Norwegian krone'}]}
    {id: 'CURRENCY_DENOM', name: 'Currency denominator', values: [{id: 'EUR', name: 'Euro'}]}
    {id: 'EXR_TYPE', name: 'Exchange rate type', values: [{id: 'SP00', name: 'Bilateral exchange rates'}]}
  ]

  it 'should render dimension filters as a form with select fields', ->
    element = React.createElement Filters, {series: s, dimensions: d}
    out = """
    <div id="filters">\
    <div class="bg-info text-right">#{s.length} series matching your query.</div>\
    <form id="dimensionFilters">\
    """
    out += createSelect(dim) for dim in d
    out += "</form></div>"
    wrapper = mount element
    wrapper.html().should.equal out
