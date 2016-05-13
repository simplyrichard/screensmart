Screensmart.Actions =
  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (response, key, value) ->
    answerValues = {}
    response.questions.forEach (question) ->
      answerValues[question.key] = question.answer_value
    answerValues[key] = value
    syncResponse(answerValues)
    type: 'SET_ANSWER'
    key: key
    value: value

  updateResponse: (answerValues = []) ->
    syncResponse(answerValues)
    type: 'UPDATE_RESPONSE'

  receiveResponseUpdate: (data) ->
    type: 'RECEIVE_RESPONSE_UPDATE'
    response: data.response

syncResponse = (answerValues = []) ->
  $.ajax '/responses',
    method: 'POST'
    dataType: 'json'
    contentType: 'application/json'
    data: JSON.stringify
      answer_values: answerValues
    headers:
      'X-CSRF-Token': window.csrfToken
  .fail (xhr, status, error) ->
    throw new Error error
  .done (data) ->
    Screensmart.store.dispatch Screensmart.Actions.receiveResponseUpdate(data)
