expect = require('chai').expect
should = require('chai').should()
{ActionTypes} = require '../../src/constants/action-types'
hclActions = require '../../src/actions/hcl-actions'
nock = require 'nock'
sinon = require 'sinon'

describe 'Hierarchical codelist actions', ->

  describe 'Actions creators', ->
    it 'should allow creating FETCH_HCL (state: loaded) actions', ->
      hclActions.should.have.property 'hclLoaded'
    it 'should allow creating FETCH_HCL (state: loading) actions', ->
      hclActions.should.have.property 'hclLoading'
    it 'should allow creating the async action to fetch a hierarchy', ->
      hclActions.should.have.property 'fetchHCL'

  describe 'Actions for HCL loading', ->

    describe 'Actions indicating the hierarchy is being loaded', ->
      it 'should have the proper type', ->
        action = hclActions.hclLoading()
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_HCL
        should.not.exist(action.payload)

    describe 'Actions after hierarchy successfully loaded', ->
      func = hclActions.hclLoaded
      payload = {mu: ['DE'], nmu: ['DK']}

      it 'should have the proper type', ->
        action = func payload
        action.should.have.property 'type'
        action.type.should.equal ActionTypes.FETCH_HCL
        action.payload.should.not.be.undefined

      it 'should have a valid hierarchy object as payload', ->
        expect(func.bind(func, 2)).to.throw TypeError
        expect(func.bind(func, null)).to.throw TypeError
        expect(func.bind(func, {name: "Categories"})).to.throw TypeError
        expect(func.bind(func, [])).to.throw TypeError
        expect(func.bind(func, [{id: 'Category Scheme'}])).to.throw TypeError
        action = func payload
        action.should.have.property 'payload'
        action.payload.should.equal payload

      it 'should allow passing error information', ->
        error = new Error('Could not retrieve the hierarchy')
        action = func error
        action.error.should.be.true
        action.payload.should.equal error

  describe 'Actions for fetching a hierarchy', ->

    func = hclActions.fetchHCL

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
          <str:HierarchicalCodelists>
              <str:HierarchicalCodelist id="HCL_COUNTRY_GROUPINGS" agencyID="TUX" version="1.0" urn="urn:sdmx:org.sdmx.infomodel.codelist.HierarchicalCodelist=TUX:HCL_COUNTRY_GROUPINGS(1.0)">
              <com:Name>List of country groupings</com:Name>
              <str:Hierarchy id="EU_GROUPINGS_PROTOCOL" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL">
                <com:Name>EU countries sorted by protocol order</com:Name>
                <str:HierarchicalCode id="1" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.1">
                  <str:Code>
                    <Ref id="EA" maintainableParentID="CL_COUNTRY_GROUPINGS" maintainableParentVersion="1.0" agencyID="ECB.DISS" package="codelist" class="Code"/>
                  </str:Code>
                  <str:HierarchicalCode id="1" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.1.1">
                    <str:Code>
                      <Ref id="BE" maintainableParentID="CL_AREA_EE" maintainableParentVersion="1.0" agencyID="ECB" package="codelist" class="Code"/>
                    </str:Code>
                  </str:HierarchicalCode>
                  <str:HierarchicalCode id="2" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.1.2">
                    <str:Code>
                      <Ref id="NL" maintainableParentID="CL_AREA_EE" maintainableParentVersion="1.0" agencyID="ECB" package="codelist" class="Code"/>
                    </str:Code>
                  </str:HierarchicalCode>
                  <str:HierarchicalCode id="3" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.1.3">
                    <str:Code>
                      <Ref id="LU" maintainableParentID="CL_AREA_EE" maintainableParentVersion="1.0" agencyID="ECB" package="codelist" class="Code"/>
                    </str:Code>
                  </str:HierarchicalCode>
                </str:HierarchicalCode>
                <str:HierarchicalCode id="2" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.2">
                  <str:Code>
                    <Ref id="NEA" maintainableParentID="CL_COUNTRY_GROUPINGS" maintainableParentVersion="1.0" agencyID="ECB.DISS" package="codelist" class="Code"/>
                  </str:Code>
                  <str:HierarchicalCode id="1" urn="urn:sdmx:org.sdmx.infomodel.codelist.Hierarchy=TUX:HCL_COUNTRY_GROUPINGS(1.0).EU_GROUPINGS_PROTOCOL.2.1">
                    <str:Code>
                      <Ref id="DK" maintainableParentID="CL_AREA_EE" maintainableParentVersion="1.0" agencyID="ECB" package="codelist" class="Code"/>
                    </str:Code>
                  </str:HierarchicalCode>
                </str:HierarchicalCode>
              </str:Hierarchy>
            </str:HierarchicalCodelist>
          </str:HierarchicalCodelists>
        </mes:Structures>
      </mes:Structure>
      '''
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('hierarchicalcodelist') > -1)
        .reply 200, out
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/hierarchicalcodelist')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.should.eventually.equal out
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_HCL'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_HCL'
        hcl = secondAction.payload
        hcl.should.include.keys ['mu', 'nmu']
        hcl.mu.should.be.an 'array'
        hcl.mu.should.have.length 3
        hcl.mu.should.deep.equal ['BE', 'NL', 'LU']
        hcl.nmu.should.be.an 'array'
        hcl.nmu.should.have.length 1
        hcl.nmu.should.deep.equal ['DK']
        should.not.exist(secondAction.error)
      )

    it 'should dispatch an error in case of problems', ->
      query = nock('http://sdw-wsrest.ecb.europa.eu')
        .get((uri) -> uri.indexOf('TST') > -1)
        .reply 500
      dispatch = sinon.spy()
      out = func('http://sdw-wsrest.ecb.europa.eu/hierarchicalcodelist/TST')(dispatch)
      out.should.be.fulfilled
      out.should.not.be.rejected
      out.then(null, null, dispatch).then(->
        dispatch.calledTwice.should.be.true
        firstAction = dispatch.firstCall.args[0]
        secondAction = dispatch.secondCall.args[0]
        firstAction.type.should.equal 'FETCH_HCL'
        should.not.exist(firstAction.payload)
        should.not.exist(firstAction.error)
        secondAction.type.should.equal 'FETCH_HCL'
        should.exist(secondAction.payload)
        secondAction.error.should.be.true
      )
