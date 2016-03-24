should = require('chai').should()
{Filters} = require '../../../src/components/filters/filters.coffee'
React = require 'react'
{mount} = require 'enzyme'
jsdom = require 'mocha-jsdom'

describe 'Filters component', ->

  jsdom()

  s = ['A.NOK.EUR.SP00', 'A.CHF.EUR.SP00']
  d = [
    {id: 'FREQ', name: 'Frequency', values: [{id: 'A', name: 'Annual'}]}
    {id: 'CURRENCY', name: 'Currency', values: [{id: 'NOK', name: 'Norwegian krone'}, {id: 'CHF', name: 'Swiss Franc'}]}
    {id: 'CURRENCY_DENOM', name: 'Currency denominator', values: [{id: 'EUR', name: 'Euro'}]}
    {id: 'EXR_TYPE', name: 'Exchange rate type', values: [{id: 'SP00', name: 'Bilateral exchange rates'}]}
  ]

  it 'should render dimension filters as a form with select fields', ->
    element = React.createElement Filters, {series: s, dimensions: d}
    out = """
    <div id="filters">\
    <div class="bg-info">#{s.length} series matching your query.</div>\
    <form id="dimensionFilters">\
    <div class="form-group">\
    <label for="fltr_#{d[0].id}">#{d[0].name} (#{d[0].values.length})</label>\
    <select id="fltr_#{d[0].id}" class="form-control" multiple="" disabled="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-select-on-close="true" \
    data-close-on-select="false">\
    <option id=\"#{d[0].values[0].id}\">#{d[0].values[0].name}</option>\
    </select>\
    </div>\
    <div class="form-group">\
    <label for="fltr_#{d[1].id}">#{d[1].name} (#{d[1].values.length})</label>\
    <select id="fltr_#{d[1].id}" class="form-control" multiple="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-select-on-close="true" \
    data-close-on-select="false">\
    <option id=\"#{d[1].values[0].id}\">#{d[1].values[0].name}</option>\
    <option id=\"#{d[1].values[1].id}\">#{d[1].values[1].name}</option>\
    </select>\
    </div>\
    <div class="form-group">\
    <label for="fltr_#{d[2].id}">#{d[2].name} (#{d[2].values.length})</label>\
    <select id="fltr_#{d[2].id}" class="form-control" multiple="" disabled="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-select-on-close="true" \
    data-close-on-select="false">\
    <option id=\"#{d[2].values[0].id}\">#{d[2].values[0].name}</option>\
    </select>\
    </div>\
    <div class="form-group">\
    <label for="fltr_#{d[3].id}">#{d[3].name} (#{d[3].values.length})</label>\
    <select id="fltr_#{d[3].id}" class="form-control" multiple="" disabled="" \
    data-placeholder="Select an item or start typing to search" \
    data-allow-clear="true" data-select-on-close="true" \
    data-close-on-select="false">\
    <option id=\"#{d[3].values[0].id}\">#{d[3].values[0].name}</option>\
    </select>\
    </div>\
    </form>\
    </div>
    """
    wrapper = mount element
    wrapper.html().should.equal out
