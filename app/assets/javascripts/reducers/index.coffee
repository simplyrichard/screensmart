Screensmart.reducer = Redux.combineReducers
  messages: (messages = [], action) ->
    switch action.type
      when 'ADD_MESSAGE'
        [
          messages...
          action.message
        ]
      else
        messages

  response: (response = { questions: [], loading: true, done: false }, action) ->
    switch action.type
      when 'UPDATE_RESPONSE'
        questions: response.questions
        loading: true
        done: response.done
      when 'RECEIVE_RESPONSE_UPDATE'
        questions: action.response.questions
        loading: false
        done: action.response.done
      when 'SET_ANSWER'
        # TODO implement
        response
      else
        response
