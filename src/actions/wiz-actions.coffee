{createAction} = require 'redux-actions'
{ActionTypes} = require '../constants/action-types.coffee'

# Creates an action indicating that the step displayed in the wizard has changed
#
# @param [Number] step a number between 1 and 4
#
wizstepChanged = (step) ->
  unless typeof step is 'number' and 0 < step < 5
    throw TypeError 'The step must be a number between 1 and 4'
  createAction(ActionTypes.CHANGE_WIZSTEP)(step)

module.exports =
  wizstepChanged: wizstepChanged
