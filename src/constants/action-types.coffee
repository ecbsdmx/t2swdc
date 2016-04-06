exports.ActionTypes = class ActionTypes

  # Indicates that the process to load the category schemes has started
  @FETCH_CS: 'FETCH_CS'

  # Indicates that the process to load the category schemes is finished
  @FETCH_CS_SUCCESS: 'FETCH_CS_SUCCESS'

  # Indicates that the process to load the category schemes has failed
  @FETCH_CS_FAILURE: 'FETCH_CS_FAILURE'

  # Indicates that the process to load the data is finished
  @FETCH_DATA_SUCCESS: 'FETCH_DATA_SUCCESS'

  # Indicates that the user has selected a category
  @SELECT_CATEGORY: 'SELECT_CATEGORY'

  # Indicates that the user has selected a dataflow
  @SELECT_DATAFLOW: 'SELECT_DATAFLOW'

  # Indicates that the user has selected the data he is interested in
  @SELECT_DATA: 'SELECT_DATA'
