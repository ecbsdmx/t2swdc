sdmxrest = require 'sdmx-rest'

chunkSize = 1000
fieldNames = []
fieldTypes = []
dataToReturn = []
measureDimensionIndex = null

#-------------------------------------------------------------------------------

submit = (url, index) ->
  connectionData = { url: url, measureDimIndex: -1 }
  connectionData.measureDimIndex = index unless isNaN(index) or
    index is null or index is undefined
  tableau.connectionData = JSON.stringify connectionData
  tableau.connectionName = "SDMX-REST Connection"
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
            if not c.keyPosition? then c.keyPosition = dimPos
            dimPos += 1
            keyPos = c.keyPosition + 1 # keyPosition is zero-based
            # assumes there will always be less than 99 dimensions
            prefix = if keyPos < 10 then "0#{keyPos}" else "#{keyPos}"
          c.name = "#{prefix} - #{c.name}"
          c.type = type
          c.isDimension = (type is 'dimensions')
          c.isAttribute = (type is 'attributes')
          c.level = level
          c

  components


formatDT = (d) -> (new Date(d)).toISOString()[0..18].replace('T',' ')


processResponse = (response) ->
  msg = JSON.parse response
  components = getComponents msg.structure
  mDimPos = -1

  for c, i in components
    c.index = i
    if 0 <= measureDimensionIndex
      mDimPos = i if +c.keyPosition is measureDimensionIndex
    c.columnNames = switch
      when c.values[0]?.start? then [c.name, "#{c.name} start", "#{c.name} end"]
      when c.values[0]?.id? then [c.name, "#{c.name} ID"]
      else c.name
    c.columnTypes = switch
      when c.values[0]?.start? then ['string', 'datetime', 'datetime']
      when c.values[0]?.id? then ['string', 'string']
      else 'string'
    c.columnValues = switch
      when c.values[0]?.start?
        ([v.name, formatDT(v.start), formatDT(v.end)] for v in c.values)
      when c.values[0]?.id?
        ([v.name, v.id] for v in c.values)
      else
        ([v.name] for v in c.values)

  fieldNames = [].concat.apply [],
    (c.columnNames for c, i in components when i isnt mDimPos)
  fieldTypes = [].concat.apply [],
    (c.columnTypes for c, i in components when i isnt mDimPos)

  if mDimPos < 0
    fieldNames.push 'Observation Value'
    fieldTypes.push 'float'
    dataToReturn = getTableData msg, components
  else
    for v in components[mDimPos].values
      fieldNames.push v.name
      fieldTypes.push 'float'
    dataToReturn = getTableDataPivoted msg, components, mDimPos

# returns observations in a flattened array:
# [ds dims, ser dims, obs dims, ds attrs, ser attrs, obs attrs, obs value]
flattenObservations = (msg) ->
  dsDims = msg.structure.dimensions.dataSet?.map (d) -> 0
  dsAttrs = msg.structure.attributes?.dataSet?.map (d) -> 0
  dsDims ?= []
  dsAttrs ?= []
  results = []

  for dataset in msg.dataSets
    for seriesKey, series of dataset.series
      seriesDims = dsDims.concat seriesKey.split(':').map( (d) -> +d )
      seriesAttrs = dsAttrs.concat series.attributes
      for obsKey, obs of series.observations
        obsRow = seriesDims.concat(+obsKey, seriesAttrs, obs[1..])
        obsRow.push obs[0]
        results.push obsRow

  return results


getTableData = (msg, components) ->
  obsArray = flattenObservations msg
  columnValues = (c.columnValues for c in components)
  results = []

  mapToValue = (i, j) ->
    return i unless i?
    return i if (columnValues.length - 1) < j
    return columnValues[j][i]

  for obsRow in obsArray
    results.push [].concat.apply([], obsRow.map(mapToValue))

  return results


getTableDataPivoted = (msg, components, mDimPos) ->
  obsArray = flattenObservations msg
  obsMap = {}
  results = []
  dimCount = 0
  dimCount += 1 for c in components when c.isDimension
  lastDim = dimCount - 1
  firstAttr = lastDim + 1
  attrCount = 0
  attrCount += 1 for c in components when c.isAttribute
  lastAttr = firstAttr + attrCount - 1
  lastValue = components[mDimPos].values.length - 1
  columnValues = (c.columnValues for c, i in components when i isnt mDimPos)

  # group observations by the key
  for obs in obsArray
    key = obs[0..lastDim]
    key.splice(mDimPos, 1)  # Remove the measure dimension from the key
    key = key.join(':')     # Join dimensions for the groupping key
    obsMap[key] ?= (null for [0..lastValue])  # Reserve a slot for each measure
    obsMap[key][obs[mDimPos]] = obs # Allocate the slot for the measure

  obsArray = []
  for key, value of obsMap
    obs = key.split ':'

    obsValues = (null for [0..lastValue])
    for obs2, i in value when obs2?
      attributes = obs2[firstAttr..lastAttr] # Assume attributes are same
      obsValues[i] = obs2[obs2.length - 1] # Take the obs value and allocate

    obs = obs.concat attributes
    obsArray.push obs.concat obsValues

  mapToValue = (i, j) ->
    return i unless i?
    return i if (columnValues.length - 1) < j
    return columnValues[j][i]

  for obsRow in obsArray
    results.push [].concat.apply([], obsRow.map(mapToValue))

  return results

#-------------------------------------------------------------------------------

makeRequest = (url, measureDimIndex, callback) ->
  measureDimensionIndex = measureDimIndex

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
    connData = JSON.parse tableau.connectionData
    callback = () -> tableau.headersCallback fieldNames, fieldTypes
    makeRequest connData.url, connData.measureDimIndex, callback

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
