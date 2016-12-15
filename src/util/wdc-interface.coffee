sdmxrest = require 'sdmx-rest'

chunkSize = 1000
fieldNames = []
fieldTypes = []
dataToReturn = []

#-------------------------------------------------------------------------------

submit = (url, dimension) ->
  tableau.connectionData = JSON.stringify { url: url, dimension: dimension }
  tableau.connectionName = 'SDMX-REST Connection'
  tableau.submit()

#-------------------------------------------------------------------------------

getComponents = (structure) ->
  components = []
  dimPos = 0

  for type in ['dimensions', 'attributes']
    for level in ['dataSet', 'series', 'observation']
      if structure[type]?[level]?
        components = components.concat structure[type][level].map (c) ->
          if type is 'attributes'
            prefix = "M"
          else
            dimPos += 1
            if c.keyPosition?
              keyPos = c.keyPosition + 1 # keyPosition is zero-based
            else
              keyPos = dimPos
            # assumes there will always be less than 99 dimensions
            prefix = if keyPos < 10 then "0#{keyPos}" else "keyPos"
          c.name = "#{prefix} - #{c.name}"
          c.type = type
          c.level = level
          c

  components


formatDT = (d) -> (new Date(d)).toISOString()[0..18].replace('T',' ')


processResponse = (response) ->
  msg = JSON.parse response
  components = getComponents msg.structure

  columnNames = for c in components
    switch
      when c.values[0]?.start? then [c.name, "#{c.name} start", "#{c.name} end"]
      when c.values[0]?.id? then [c.name, "#{c.name} ID"]
      else c.name

  columnTypes = for c in components
    switch
      when c.values[0]?.start? then ['string', 'datetime', 'datetime']
      when c.values[0]?.id? then ['string', 'string']
      else 'string'

  columnValues = for c in components
    switch
      when c.values[0]?.start?
        ([v.name, formatDT(v.start), formatDT(v.end)] for v in c.values)
      when c.values[0]?.id?
        ([v.name, v.id] for v in c.values)
      else
        ([v.name] for v in c.values)

  columnNames.push 'Observation Value'
  columnTypes.push 'float'

  fieldNames = [].concat.apply [], columnNames
  fieldTypes = [].concat.apply [], columnTypes
  dataToReturn = getTableData msg, columnValues


getTableData = (msg, columnValues) ->
  dsDims = msg.structure.dimensions.dataSet?.map (d) -> 0
  dsAttrs = msg.structure.attributes?.dataSet?.map (d) -> 0
  dsDims ?= []
  dsAttrs ?= []
  results = []

  mapToValue = (i, j) -> if i? then columnValues[j][i] else i

  for dataset in msg.dataSets
    for seriesKey, series of dataset.series
      seriesDims = dsDims.concat seriesKey.split(':').map( (d) -> +d )
      seriesAttrs = dsAttrs.concat series.attributes
      for obsKey, obs of series.observations
        obsRow = seriesDims.concat(+obsKey, seriesAttrs, obs[1..])
        obsRow = [].concat.apply([], obsRow.map(mapToValue))
        obsRow.push obs[0]
        results.push obsRow

  return results

#-------------------------------------------------------------------------------

makeRequest = (url, callback) ->
  errorHandler = (error) ->
    console.log error
    tableau.abortWithError "#{error}"

  sdmxrest.request(url)
    .then(processResponse)
    .then(callback)
    .catch(errorHandler)


response = () ->
  {
    fieldNames: fieldNames
    fieldTypes: fieldTypes
    dataToReturn: dataToReturn
  }

#-------------------------------------------------------------------------------

registerConnector = () ->
  connector = tableau.makeConnector()

  connector.getColumnHeaders = ->
    connectionData = JSON.parse tableau.connectionData
    callback = () -> tableau.headersCallback fieldNames, fieldTypes
    makeRequest connectionData.url, callback

  connector.getTableData = (lastRecordToken) ->
    if lastRecordToken.length is 0
      start = 0
    else
      start = +lastRecordToken

    end = start + chunkSize
    hasMoreData = end < dataToReturn.length

    tableau.dataCallback dataToReturn[start...end], "#{end}", hasMoreData

  connector.init = ->
    # Show full UI, including the UI to let the user sign in via OAuth
    tableau.initCallback()

  tableau.registerConnector connector

#-------------------------------------------------------------------------------

module.exports =
  registerConnector: registerConnector
  submit: submit
  makeRequest: makeRequest
  response: response
