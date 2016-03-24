should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types.coffee'
csActions = require '../../src/actions/cs-actions.coffee'

describe 'Category scheme actions', ->

  describe 'Actions creators', ->
    it 'should allow creating SELECT_CATEGORY actions', ->
      csActions.should.have.property 'categorySelected'

  describe 'Actions for category selection', ->
    func = csActions.categorySelected

    it 'should have the proper type', ->
      action = func 'urn'
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.SELECT_CATEGORY

    it 'should have the unique id of the category as payload', ->
      uid = 'test'
      action = func uid
      action.should.have.property 'payload'
      action.payload.should.equal uid

    it 'should have a non-empty string as unique id', ->
      expect(func.bind(func, 2)).to.throw TypeError
      expect(func.bind(func, '')).to.throw TypeError
      expect(func.bind(func, ' ')).to.throw TypeError

  describe 'Actions for category scheme loading', ->
    func = csActions.csLoaded
    payload = [{categories: []}]

    it 'should have the proper type', ->
      action = func payload
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.FETCH_CS_SUCCESS

    it 'should have a valid category scheme object as payload', ->
      expect(func.bind(func, 2)).to.throw TypeError
      expect(func.bind(func, null)).to.throw TypeError
      expect(func.bind(func, {name: "Categories"})).to.throw TypeError
      expect(func.bind(func, {categoryschemes: []})).to.throw TypeError
      expect(func.bind(func, [])).to.throw TypeError
      expect(func.bind(func, [{id: 'Category Scheme'}])).to.throw TypeError
      action = func payload
      action.should.have.property 'payload'
      action.payload.should.equal payload

    it 'should allow passing error information', ->
      error = new Error("Could not retrieve the category schemes")
      action = func error
      action.error.should.be.true
      action.payload.should.equal error
