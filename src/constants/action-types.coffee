exports.ActionTypes = class ActionTypes

  # Indicates that the process to load the countries hierarchical CL is running
  @FETCH_HCL: 'FETCH_HCL'

  # Indicates that the process to load the category schemes is running
  @FETCH_CS: 'FETCH_CS'

  # Indicates that the process to fetch data is running
  @FETCH_DATA: 'FETCH_DATA'

  # Indicates that the user has selected a category
  @SELECT_CATEGORY: 'SELECT_CATEGORY'

  # Indicates that the user has selected a dataflow
  @SELECT_DATAFLOW: 'SELECT_DATAFLOW'

  # Indicates that the user has selected the data he is interested in
  @SELECT_DATA: 'SELECT_DATA'

  # Indicate that the user has selected a dimension to be used as measure
  @SELECT_MEASURE: 'SELECT_MEASURE'
