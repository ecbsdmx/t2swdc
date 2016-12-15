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
      response.fieldTypes.should.be.an('array').with.lengthOf(42)
      response.fieldTypes.should.have.members(['string', 'datetime', 'float'])
      response.dataToReturn.should.be.an('array').with.lengthOf(4)
      done()

    wdcInterface.makeRequest 'http://sdw-wsrest.ecb.europa.eu/service/EXR',
      checkResult

    return
