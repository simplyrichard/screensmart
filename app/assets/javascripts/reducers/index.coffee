merge = (originalObject, updatedProperties) ->
  $.extend {}, originalObject, [].splice.call(arguments, 1)...

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

  response: (response, action) ->
    switch action.type
      when 'SET_RESPONSE_LOADING'
        merge response, loading: true
      when 'RECEIVE_RESPONSE_UPDATE'
        merge response, action.response,
                        loading: false
      else
        questions: []
        loading: true
        done: false
