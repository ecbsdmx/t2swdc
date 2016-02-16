exports.ActionTypes = class ActionTypes

  # Indicates that the process to load the category schemes is finished
  @CS_LOADED: 'CS_LOADED'

  # Indicates that the process to load the DSD and its constraints is finished
  @DSD_LOADED: 'DSD_LOADED'

  # Indicates that the process to load the data is finished
  @DATA_LOADED: 'DATA_LOADED'

  # Indicates that the user has selected a category
  @CATEGORY_SELECTED: 'CATEGORY_SELECTED'

  # Indicates that the user has selected a dataflow
  @DATAFLOW_SELECTED: 'DATAFLOW_SELECTED'

  # Indicates that the user has changed the dimension filters
  @FILTERS_CHANGED: 'FILTERS_CHANGED'

  # Indicates that the user has selected the data he is interested in
  @DATA_SELECTED: 'DATA_SELECTED'

  # Indicates that the step displayed in the wizard has changed
  @WIZSTEP_CHANGED: 'WIZSTEP_CHANGED'
