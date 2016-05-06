React = require 'react'
dom = React.DOM
{Filter} = require './filter'
{MatchingSeries} = require './matching-series'
crossfilter = require 'crossfilter2'
Immutable = require 'immutable'

prevCheck = null
addPositions = (dimension) ->
  c.pos = idx for c, idx in dimension.values
  dimension

seriesKeyToObject = (item) ->
  object = {}
  object[idx] = v for v, idx in item.split(':')
  object

createFilters = (dimensions, seriesDim) ->
  (createFilter(i, seriesDim[idx]) for i, idx in dimensions)

createFilter = (dimension, smd) ->
  indices = (i.key for i in dimension.group().all() when i.value isnt 0)
  codes = (smd.values[i] for i in indices)
  if smd.id is 'REF_AREA'
    codes.unshift {id: '0EU', name: 'All EU countries'}
    codes.unshift {id: '0MU', name: 'All MU countries'}
    codes.unshift {id: '0NMU', name: 'EU countries excluding MU'}
  {id: smd.id, name: smd.name, values: codes}

createSelectField = (d, idx) ->
  React.createElement Filter,
    {key: "dim_#{d.id}", id: d.id, name: d.name, values: d.values, pos: idx}

formatSelection = (item, field) ->
  $(field).parent().tooltip({title: item.text})
  item.text.substring(0, item.text.indexOf(' -'))

Filters = React.createClass

  universe: {}  # The crossfilter universe
  dims: []      # The crossfilter dimensions
  smd: []       # The SDMX series dimensions
  areas: {}   # The indices for the country groups
  isInitial: false

  handleCountryGroupings: (values, grp, field) ->
    v1 = (val for val in values when val isnt grp)
    v2 = (@areas.mu[k] for k of @areas.mu \
      when @areas.mu[k] not in v1 and grp isnt '0NMU')
    v3 = (@areas.nmu[k] for k of @areas.nmu \
      when @areas.nmu[k] not in v1 and grp isnt '0MU')
    values = v1.concat v2, v3
    $(field).val(values).trigger 'change'
    values

  handleChanged: (ev) ->
    fieldNo = ev.currentTarget.id.replace('fltr_', '')
    values = $(ev.currentTarget).val()
    if values
      fld = $(ev.currentTarget)
      values = @handleCountryGroupings(values, '0EU', fld) if '0EU' in values
      values = @handleCountryGroupings(values, '0MU', fld) if '0MU' in values
      values = @handleCountryGroupings(values, '0NMU', fld) if '0NMU' in values
      @dims[fieldNo].filterFunction (i) -> i in values
    else
      @dims[fieldNo].filterAll()
    @forceUpdate()

  handleCheckboxChanged: (ev) ->
    if prevCheck and prevCheck isnt ev.currentTarget
      $(prevCheck).prop('checked', false).change()
    prevCheck = ev.currentTarget

  componentWillUpdate: (nextProps, nextState) ->
    # When getting new data, we need to create crossfilter universe & dimensions
    if nextProps.series.equals? and not nextProps.series.equals?(@props.series)
      @universe = {}
      @areas = {mu: {}, nmu: {}}
      @dims = []
      @smd = []
      series = (seriesKeyToObject key for key of nextProps.series.toJS())
      @universe = crossfilter series
      @dims.push @universe.dimension((d) -> d[k]) for k of series[0]
      @smd = (addPositions i for i in nextProps.dimensions.toJS())
      @isInitial = true
      @areas.mu[c] = undefined for c in @props.hierarchies.mu
      @areas.nmu[c] = undefined for c in @props.hierarchies.nmu
      for dim in @smd when dim.id is 'REF_AREA'
        for val in dim.values
          if val.id of @areas.mu then @areas.mu[val.id] = "#{val.pos}"
          else if val.id of @areas.nmu then @areas.nmu[val.id] = "#{val.pos}"
      @isInitial = true

  componentDidUpdate: ->
    if @isInitial and $?
      $('select').select2({templateSelection: formatSelection})
      $('select').on('select2:select', @handleChanged)
      $('select').on('select2:unselect', @handleChanged)
      $('#filters :checkbox').bootstrapToggle()
      $('#filters :checkbox').change @handleCheckboxChanged

      @isInitial = false
    if $? # If there is only one value in the field, it should be selected
      $('select').each(() ->
        select = $(this)
        options = $(select).find 'option'
        if options.length is 1
          $(select).val($(options[0]).val()).trigger 'change'
      )

  shouldComponentUpdate: (nextProps, nextState) ->
    nextProps.series isnt @props.series or nextProps.busy or nextProps.error

  render: ->
    if @props.busy
      dom.div {id: 'loading', className: 'text-center'},
        dom.span {className: 'glyphicon glyphicon-repeat gly-spin'}
    else if @props.error
      dom.div {className: 'alert alert-danger'}, @props.error.message
    else if @universe.hasOwnProperty 'groupAll'
      filters = createFilters @dims, @smd
      nodes = (createSelectField(d, idx) for d, idx in filters)
      $('.btn-next').removeAttr('disabled') if $
      dom.div (id: 'filters'),
        React.createElement MatchingSeries,
          {name: @props.name, number: @universe.groupAll().value()}
        dom.form {id: 'dimensionFilters'}, nodes
    else false

Filters.propTypes =
  dimensions: React.PropTypes.instanceOf(Immutable.List).isRequired
  series: React.PropTypes.instanceOf(Immutable.Map).isRequired
  name: React.PropTypes.string.isRequired
  error: React.PropTypes.object.isRequired
  busy: React.PropTypes.bool.isRequired
  hierarchies: React.PropTypes.object.isRequired

exports.Filters = Filters
