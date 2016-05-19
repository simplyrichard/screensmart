Screensmart.Actions =
  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (key, value) ->
    (dispatch) =>
      dispatch @_setAnswer(key, value)
      dispatch @updateResponse()

  _setAnswer: (key, value) ->
    type: 'SET_ANSWER'
    key: key
    value: value

  updateResponse: ->
    (dispatch, getState) ->
      response = getState().response
      syncResponse(response).then (data) ->
        dispatch Screensmart.Actions.receiveResponseUpdate(data)

  setResponseLoading: ->
    type: 'SET_RESPONSE_LOADING'

  receiveResponseUpdate: (data) ->
    type: 'RECEIVE_RESPONSE_UPDATE'
    response: data.response

syncResponse = (response) ->
  $.ajax '/responses',
    method: 'POST'
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify
      response: response
    headers:
      'X-CSRF-Token': window.csrfToken
    error: (jqXHR, textStatus, errorThrown) ->
      throw new Error "XHR failed with error: #{errorThrown}"
