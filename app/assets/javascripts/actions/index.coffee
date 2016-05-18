Screensmart.Actions =
  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (key, value) ->
    (dispatch, getState) ->
      { response } = getState()
      answerValues = {}
      filledOutQuestions = response.questions.filter (question) ->
        question.answer_value?
      filledOutQuestions.forEach (question) ->
        answerValues[question.key] = question.answer_value
      answerValues[key] = value
      dispatch Screensmart.Actions.updateResponse(answerValues)

  updateResponse: (answerValues = []) ->
    (dispatch, getState) ->
      syncResponse(answerValues)
      dispatch Screensmart.Actions.setResponseLoading()

  setResponseLoading: ->
    type: 'SET_RESPONSE_LOADING'

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
