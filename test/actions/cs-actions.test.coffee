should = require('chai').should()
expect = require('chai').expect
{ActionTypes} = require '../../src/constants/action-types'
csActions = require '../../src/actions/cs-actions'
nock = require 'nock'
sinon = require 'sinon'

describe 'Category scheme actions', ->

  describe 'Actions creators', ->
    it 'should allow creating SELECT_CATEGORY actions', ->
      csActions.should.have.property 'categorySelected'
    it 'should allow creating FETCH_CS (state: loaded) actions', ->
      csActions.should.have.property 'csLoaded'
    it 'should allow creating FETCH_CS (state: loading) actions', ->
      csActions.should.have.property 'csLoading'
    it 'should allow creating the async action to fetch a category scheme', ->
      csActions.should.have.property 'fetchCS'

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
      (func.bind(func, 2)).should.throw TypeError
      (func.bind(func, '')).should.throw TypeError
      (func.bind(func, ' ')).should.throw TypeError

  describe 'Actions for category scheme loading', ->

    describe 'Actions indicating category scheme is being loaded', ->
      it 'should have the proper type', ->
        action = csActions.csLoading()
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_CS
        should.not.exist(action.payload)

    describe 'Actions after category scheme successfully loaded', ->
      func = csActions.csLoaded
      payload = [{categories: []}]

      it 'should have the proper type', ->
        action = func payload
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_CS
        action.payload.should.not.be.undefined

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

  describe 'Actions for fetching a category scheme', ->

    func = csActions.fetchCS

    it 'should return a function', ->
      func.should.be.a 'function'

    it 'should call the dispatch function twice', ->
      out = '''
      <mes:Structure
        xmlns:mes="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/message"
        xmlns:str="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/structure"
        xmlns:com="http://www.sdmx.org/resources/sdmxml/schemas/v2_1/common">
        <mes:Header>
          <mes:ID>ID</mes:ID>
          <mes:Test>true</mes:Test>
          <mes:Prepared>2016-04-25T07:46:00Z</mes:Prepared>
          <mes:Sender id="Tux"/>
        </mes:Header>
        <mes:Structures>
          <str:Dataflows>
              <str:Dataflow id="FLOW_01" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.datastructure.Dataflow=TUX:FLOW_01(1.0)">
              <com:Name>Flow 01</com:Name>
            </str:Dataflow>
            <str:Dataflow id="FLOW_02" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.datastructure.Dataflow=TUX:FLOW_02(1.0)">
              <com:Name>Flow 02</com:Name>
            </str:Dataflow>
            <str:Dataflow id="FLOW_03" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.datastructure.Dataflow=TUX:FLOW_03(1.0)">
              <com:Name>Flow 03</com:Name>
            </str:Dataflow>
          </str:Dataflows>
          <str:CategorySchemes>
            <str:CategoryScheme id="TEST_CS" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.CategoryScheme=TUX:TEST_CS(1.0)">
              <com:Name>A category scheme</com:Name>
              <str:Category id="01" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.Category=TUX:TEST_CS(1.0).01">
                <com:Name>Category 01</com:Name>
              </str:Category>
              <str:Category id="02" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.Category=TUX:TEST_CS(1.0).02">
                <com:Name>Category 02</com:Name>
              </str:Category>
            </str:CategoryScheme>
          </str:CategorySchemes>
          <str:Categorisations>
            <str:Categorisation id="cat1" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.Categorisation=TUX:cat1(1.0)">
              <com:Name>Categorisation 01</com:Name>
              <str:Source>
                <Ref id="FLOW_01" version="1.0" agencyID="TUX" package="datastructure" class="Dataflow"/>
              </str:Source>
              <str:Target>
                <Ref id="01" maintainableParentID="TEST_CS" maintainableParentVersion="1.0" agencyID="TUX" package="categoryscheme" class="Category"/>
              </str:Target>
            </str:Categorisation>
            <str:Categorisation id="cat2" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.Categorisation=TUX:cat2(1.0)">
              <com:Name>Categorisation 02</com:Name>
              <str:Source>
                <Ref id="FLOW_02" version="1.0" agencyID="TUX" package="datastructure" class="Dataflow"/>
              </str:Source>
              <str:Target>
                <Ref id="01" maintainableParentID="TEST_CS" maintainableParentVersion="1.0" agencyID="TUX" package="categoryscheme" class="Category"/>
              </str:Target>
            </str:Categorisation>
            <str:Categorisation id="cat3" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.categoryscheme.Categorisation=TUX:cat3(1.0)">
              <com:Name>Categorisation 03</com:Name>
              <str:Source>
                <Ref id="FLOW_03" version="1.0" agencyID="TUX" package="datastructure" class="Dataflow"/>
              </str:Source>
              <str:Target>
                <Ref id="02" maintainableParentID="TEST_CS" maintainableParentVersion="1.0" agencyID="TUX" package="categoryscheme" class="Category"/>
              </str:Target>
            </str:Categorisation>
          </str:Categorisations>
        </mes:Structures>
      </mes:Structure>
      '''
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('categoryscheme') > -1)
        .reply 200, out
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/categoryscheme')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.should.eventually.equal out
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_CS'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_CS'
        secondAction.payload.should.be.an 'array'
        secondAction.payload.should.have.length 1
        cs = secondAction.payload[0]
        cs.should.include.keys ['id', 'name', 'categories']
        cs.categories.should.be.an 'array'
        cs.categories.should.have.length 2
        for cat in cs.categories
          cat.should.include.keys ['id', 'name', 'dataflows']
          console.log cat
          cat.dataflows.should.have.length 2 if cat.id is '01'
          cat.dataflows.should.have.length 1 if cat.id is '02'
        should.not.exist(secondAction.error)
      )

    it 'should dispatch an error in case of problems', ->
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('TST') > -1)
        .reply 500
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/categoryscheme/TST')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_CS'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_CS'
        should.exist(secondAction.payload)
        secondAction.error.should.be.true
      )
