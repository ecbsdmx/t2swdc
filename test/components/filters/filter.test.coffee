should = require('chai').should()
{Filter} = require '../../../src/components/filters/filter.coffee'
React = require 'react'
{shallow, mount} = require 'enzyme'

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
    wrapper = mount element
    wrapper.should.have.length 1
    wrapper.find('div.form-group').should.exist
    wrapper.find('label').should.exist
    wrapper.find('select').should.exist
    wrapper.find('select').children().should.have.length 2
    wrapper.find('select').prop('multiple').should.exist
    wrapper.find('select').prop('disabled').should.be.false
    wrapper.find('select').childAt(0).text().should.equal("#{v[0].id} - #{v[0].name}")
    wrapper.find('select').childAt(1).text().should.equal("#{v[1].id} - #{v[1].name}")
    wrapper.find('input').should.exist
    wrapper.find('input').prop('type').should.equal('checkbox')
    wrapper.find('input').prop('data-toggle').should.equal('toggle')

  it 'should disable selection in case only one value is available', ->
    element = React.createElement Filter,
      {id: i, name: n, values: singleValue, pos: 0}   
    wrapper = mount element
    wrapper.should.have.length 1
    wrapper.find('select').should.exist
    wrapper.find('select').prop('disabled').should.exist
    wrapper.find('select').children().should.have.length 1

  it 'should sort by code ids', ->
    element = React.createElement Filter, {id: i, name: n, values: u, pos: 0}
    wrapper = mount element
    wrapper.find('select').children().should.have.length 2
    wrapper.find('select').childAt(0).text().should.equal("#{u[1].id} - #{u[1].name}")
    wrapper.find('select').childAt(1).text().should.equal("#{u[0].id} - #{u[0].name}")
