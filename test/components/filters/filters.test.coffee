should = require('chai').should()
{Filters} = require '../../../src/components/filters/filters'
React = require 'react'
{mount} = require 'enzyme'
Immutable = require 'immutable'

describe 'Filters component', ->

  series = {'A.NOK.EUR.SP00': {}, 'A.CHF.EUR.SP00': {}}
  dimensions = [
    {id: 'FREQ', name: 'Frequency', values: [{id: 'A', name: 'Annual'}]}
    {id: 'CURRENCY', name: 'Currency', values: [{id: 'CHF', name: 'Swiss Franc'}, {id: 'NOK', name: 'Norwegian krone'}]}
    {id: 'CURRENCY_DENOM', name: 'Currency denominator', values: [{id: 'EUR', name: 'Euro'}]}
    {id: 'EXR_TYPE', name: 'Exchange rate type', values: [{id: 'SP00', name: 'Bilateral exchange rates'}]}
  ]
  s = Immutable.Map series
  d = Immutable.List d

  it 'should render dimension filters as a form with select fields', ->
    # I did not manage to find a good way to test this component, as it
    # requires to instantiate a crossfilter universe
    element = React.createElement Filters, {series: s, dimensions: d}
    wrapper = mount element
    element.props.series.should.equal s
    element.props.dimensions.should.equal d
    try
      wrapper.update() # Ugly hack until we find how to test this component
    catch e
