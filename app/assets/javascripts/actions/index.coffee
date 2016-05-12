Screensmart.Actions =
  addMessage: (message) ->
    type: 'ADD_MESSAGE'
    message: message

  setAnswer: (answer) ->
    type: 'ADD_ANSWER'
    answer: answer

  updateResponse: (json) ->
    type: 'UPDATE_RESPONSE'
    response: json.data
