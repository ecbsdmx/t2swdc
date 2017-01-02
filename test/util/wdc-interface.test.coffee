should = require('chai').should()
wdcInterface = require '../../src/util/wdc-interface'
sdmxrest = require 'sdmx-rest'
nock = require 'nock'

describe 'Web Data Connector Interface', ->

  it 'converts SDMX-JSON format for Tableau', (done) ->
    query = nock('http://sdw-wsrest.ecb.europa.eu')
      .get((uri) -> uri.indexOf('EXR') > -1)
      .replyWithFile(200, __dirname + '/../fixtures/ECB_EXR.json')

    checkResult = () ->
      response = wdcInterface.response()
      response.fieldNames.should.be.an('array').with.lengthOf(42)
      response.fieldNames.should.include('02 - Currency')
      response.fieldNames[0].should.equal('01 - Frequency')
      response.fieldNames[1].should.equal('01 - Frequency ID')
      response.fieldNames[41].should.equal('Observation Value')
      response.fieldTypes.should.be.an('array').with.lengthOf(42)
      response.fieldTypes.should.have.members(['string', 'datetime', 'float'])
      response.fieldTypes[12].should.equal('datetime')
      response.fieldTypes[41].should.equal('float')
      response.dataToReturn.should.be.an('array').with.lengthOf(4)
      response.dataToReturn[0].should.be.an('array').with.lengthOf(42)
      response.dataToReturn[0][0].should.equal('Monthly')
      response.dataToReturn[0][41].should.equal(1.085965)
      done()

    wdcInterface.makeRequest 'http://sdw-wsrest.ecb.europa.eu/service/EXR',
      undefined,
      checkResult

    return

  it 'handles more than 9 dimensions', (done) ->
    query = nock('http://sdw-wsrest.ecb.europa.eu')
      .get((uri) -> uri.indexOf('MNA') > -1)
      .replyWithFile(200, __dirname + '/../fixtures/ECB_MNA.json')

    checkResult = () ->
      response = wdcInterface.response()
      response.fieldNames.should.include('14 - Transformation')
      done()

    wdcInterface.makeRequest 'http://sdw-wsrest.ecb.europa.eu/service/MNA',
      undefined,
      checkResult

    return

  it 'it supports setting measure dimension', (done) ->
    query = nock('http://sdw-wsrest.ecb.europa.eu')
      .get((uri) -> uri.indexOf('EXR') > -1)
      .replyWithFile(200, __dirname + '/../fixtures/ECB_EXR.json')

    checkResult = () ->
      response = wdcInterface.response()
      response.fieldNames.should.be.an('array').with.lengthOf(40)
      response.fieldNames.should.not.include('02 - Currency')
      response.fieldNames[0].should.equal('01 - Frequency')
      response.fieldNames[39].should.equal('US dollar')
      response.fieldTypes.should.be.an('array').with.lengthOf(40)
      response.fieldTypes.should.have.members(['string', 'datetime', 'float'])
      response.fieldTypes[10].should.equal('datetime')
      response.fieldTypes[39].should.equal('float')
      response.dataToReturn.should.be.an('array').with.lengthOf(4)
      response.dataToReturn[0].should.be.an('array').with.lengthOf(40)
      response.dataToReturn[0][0].should.equal('Monthly')
      response.dataToReturn[0][39].should.equal(1.085965)
      done()

    wdcInterface.makeRequest 'http://sdw-wsrest.ecb.europa.eu/service/EXR', 1,
      checkResult

    return

  it 'it supports measure dimension with multiple values', (done) ->
    query = nock('http://sdw-wsrest.ecb.europa.eu')
      .get((uri) -> uri.indexOf('EXR') > -1)
      .replyWithFile(200, __dirname + '/../fixtures/ECB_EXR1_USD_GBP.json')

    checkResult = () ->
      response = wdcInterface.response()
      response.fieldNames.should.be.an('array').with.lengthOf(41)
      response.fieldNames.should.not.include('02 - Currency')
      response.fieldNames[0].should.equal('01 - Frequency')
      response.fieldNames[39].should.equal('UK pound sterling')
      response.fieldNames[40].should.equal('US dollar')
      response.fieldTypes.should.be.an('array').with.lengthOf(41)
      response.fieldTypes.should.have.members(['string', 'datetime', 'float'])
      response.fieldTypes[10].should.equal('datetime')
      response.fieldTypes[39].should.equal('float')
      response.fieldTypes[40].should.equal('float')
      response.dataToReturn.should.be.an('array').with.lengthOf(4)
      response.dataToReturn[0].should.be.an('array').with.lengthOf(41)
      response.dataToReturn[0][0].should.equal('Monthly')
      response.dataToReturn[0][39].should.equal(0.790493636363636)
      response.dataToReturn[0][40].should.equal(1.122890909090909)
      done()

    wdcInterface.makeRequest 'http://sdw-wsrest.ecb.europa.eu/service/EXR', 1,
      checkResult

    return
