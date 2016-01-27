chai = require 'chai'
spies = require 'chai-spies'
chai.use spies
should = chai.should()
expect = chai.expect
{CategoryScheme} =
  require '../../../src/components/categoryscheme/category-scheme.coffee'
React = require 'react'
{shallow} = require 'enzyme'

describe 'Category Scheme component', ->

  cats = [
    {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
    {id:'B', name:'catB', dataflows:[]},
  ]

  it 'should render a category scheme as a bootstrap list group div', ->
    id = 'xyz'
    name = 'category scheme'
    scheme = """
    <div id="cs_#{id}" class="list-group">\
    <a id="cat_A" href="#" class="list-group-item">\
    <span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item">\
    <span class="badge badge-primary">0</span>catB</a>\
    </div>
    """
    element =
      React.createElement CategoryScheme, {id: id, name: name, categories: cats}
    wrapper = shallow element
    html = wrapper.html()
    expect(html).to.equal scheme
