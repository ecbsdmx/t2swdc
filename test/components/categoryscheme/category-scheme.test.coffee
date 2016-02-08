should = require('chai').should()
{CategoryScheme} =
  require '../../../src/components/categoryscheme/category-scheme.coffee'
React = require 'react'
{shallow} = require 'enzyme'
{categorySelected} = require '../../../src/actions/cs-actions.coffee'

describe 'Category Scheme component', ->

  cats = [
    {id:'A', name:'catA', dataflows:['flow1', 'flow2']},
    {id:'B', name:'catB', dataflows:[]},
  ]

  it 'should render a category scheme as a bootstrap list group div', ->
    [id, name] = ['xyz', 'category scheme']
    scheme = """
    <div id="cs_#{id}" class="list-group">\
    <a id="cat_A" href="#" class="list-group-item">\
    <span class="badge badge-primary">2</span>catA</a>\
    <a id="cat_B" href="#" class="list-group-item">\
    <span class="badge badge-primary">0</span>catB</a>\
    </div>
    """
    element =
      React.createElement CategoryScheme, {id: id, name: name, categories: cats,
      onCategoryClick: categorySelected}
    wrapper = shallow element
    wrapper.html().should.equal scheme
