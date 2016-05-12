Screensmart.Actions =
  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (answer) ->
    type: 'ADD_ANSWER'
    answer: answer

  updateResponse: (answerValues = []) ->
    $.ajax '/responses',
      method: 'POST'
      dataType: 'json'
      contentType: 'application/json'
      data: JSON.stringify
       answer_values: answerValues
      headers:
        'X-CSRF-Token': window.csrfToken
    .fail (xhr, status, error) ->
      console.log("Failure: #{status}, #{error}")
    .done (data) ->
      Screensmart.store.dispatch Screensmart.Actions.receiveResponseUpdate(data)
    type: 'UPDATE_RESPONSE'

  receiveResponseUpdate: (data) ->
    type: 'RECEIVE_RESPONSE_UPDATE'
    response: data.response
