exports.ActionTypes = class ActionTypes

  # Indicates that the process to load the category schemes is finished
  @FETCH_CS_SUCCESS: 'FETCH_CS_SUCCESS'

  # Indicates that the process to load the data is finished
  @FETCH_DATA_SUCCESS: 'FETCH_DATA_SUCCESS'

  # Indicates that the user has selected a category
  @SELECT_CATEGORY: 'SELECT_CATEGORY'

  # Indicates that the user has selected a dataflow
  @SELECT_DATAFLOW: 'SELECT_DATAFLOW'

  # Indicates that the user has changed a dimension filter
  @CHANGE_FILTER: 'CHANGE_FILTER'

  # Indicates that the user has selected the data he is interested in
  @SELECT_DATA: 'SELECT_DATA'

  # Indicates that the step displayed in the wizard has changed
  @CHANGE_WIZSTEP: 'CHANGE_WIZSTEP'
