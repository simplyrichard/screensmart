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
      when 'SET_ANSWER'
        [
          # TODO implement
          response
        ]
      else
        response
