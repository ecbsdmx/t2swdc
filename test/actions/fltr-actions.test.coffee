{ActionTypes} = require '../../src/constants/action-types.coffee'
fltrActions = require '../../src/actions/fltr-actions.coffee'
chai = require 'chai'
chaiAsPromised = require 'chai-as-promised'
chai.use chaiAsPromised
should = chai.should()
expect = chai.expect
assert = chai.assert
nock = require 'nock'
sinon = require 'sinon'

describe 'Filters actions', ->
  describe 'Actions creators', ->
    it 'should allow creating SELECT_DATA actions', ->
      fltrActions.should.have.property 'dataSelected'
    it 'should allow creating SELECT_MEASURE actions', ->
      fltrActions.should.have.property 'measureSelected'
    it 'should allow creating FETCH_DATA (state: Loading) actions', ->
      fltrActions.should.have.property 'dataLoading'
    it 'should allow creating FETCH_DATA (state: Loaded) actions', ->
      fltrActions.should.have.property 'dataLoaded'
    it 'should allow creating the async action to fetch data', ->
      fltrActions.should.have.property 'fetchData'

  describe 'Actions for data selection', ->
    func = fltrActions.dataSelected

    it 'should have the proper type', ->
      action = func 'http://ws-entry-point.com/data/TEST'
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.SELECT_DATA

    it 'should have the data query url as payload', ->
      url = 'http://ws-entry-point.com/data/TEST'
      action = func url
      action.should.have.property 'payload'
      action.payload.should.equal url

    it 'should have a non-empty string as iput', ->
      expect(func.bind(func, 2)).to.throw TypeError
      expect(func.bind(func, '')).to.throw TypeError
      expect(func.bind(func, ' ')).to.throw TypeError

  describe 'Actions for measure selection', ->
    func = fltrActions.measureSelected

    it 'should have the proper type', ->
      action = func 1
      action.should.have.property 'type'
      action.type.should.equal ActionTypes.SELECT_MEASURE

    it 'should have the position of the dimension as payload', ->
      action = func 1
      action.should.have.property 'payload'
      action.payload.should.equal 1

    it 'should be possible to reset the measure dimension', ->
      action = func null
      action.should.be.an('object').with.property('payload').that.is.a 'null'

    it 'should have an integer as iput', ->
      expect(func.bind(func, 'test')).to.throw TypeError
      expect(func.bind(func, [])).to.throw TypeError
      expect(func.bind(func, {})).to.throw TypeError

  describe 'Actions for data loading', ->
    describe 'Actions indicating data is being loaded', ->
      it 'should have the proper type', ->
        action = fltrActions.dataLoading()
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_DATA
        should.not.exist(action.payload)
        should.not.exist(action.error)

    describe 'Actions after data successfully loaded', ->
      func = fltrActions.dataLoaded
      payload = {header: {}, structure: {}, dataSets: []}

      it 'should have the proper type', ->
        action = func payload
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_DATA
        action.payload.should.not.be.undefined
        should.not.exist(action.error)

      it 'should have a valid SDMX-JSON data object as payload', ->
        action = func payload
        action.should.have.property 'payload'
        action.payload.should.equal payload

      it 'should perform basic type validation', ->
        expect(func.bind(func, 2)).to.throw TypeError
        expect(func.bind(func, null)).to.throw TypeError
        expect(func.bind(func, [])).to.throw TypeError

      it 'should allow passing error information', ->
        error = new Error('Could not retrieve the data')
        action = func error
        action.error.should.be.true
        action.payload.should.equal error

  describe 'Actions for data fetching', ->

    func = fltrActions.fetchData

    it 'should return a function', ->
      func.should.be.a 'function'

    it 'should call the dispatch function twice', ->
      json = {"header": {}, "structure": {}, "dataSets": []}
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('EXR') > -1)
        .reply 200, json
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/service/data/EXR')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.should.eventually.equal json
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_DATA'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_DATA'
        secondAction.payload.should.deep.equal json
        should.not.exist(secondAction.error)
      )

    it 'should dispatch an error in case of problems', ->
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('BSI') > -1)
        .reply 500
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/service/data/BSI')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_DATA'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_DATA'
        should.exist(secondAction.payload)
        secondAction.error.should.be.true
      )
