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
      when 'SET_ANSWER'
        merge responseWithoutNonFilledOutQuestions(
          responseWithAnswer(
            response,
            action.key,
            action.value
          )
        ),
        loading: true

      when 'RECEIVE_RESPONSE_UPDATE'
        merge response, action.response,
                        loading: false
      else
        questions: []
        loading: true
        done: false

responseWithAnswer = (response, key, value) ->
  index = indexOfQuestion(response, key)
  response.questions[index].answer_value = value
  response

indexOfQuestion = (response, key) ->
  response.questions.indexOf questionByKey(response, key)

questionByKey = (response, key) ->
  response.questions.filter((question) ->
    question.key == key
  )[0]

responseWithoutNonFilledOutQuestions = (response) ->
  questionsWithAnswers = response.questions.filter (question) ->
    question.answer_value?
  response.questions = questionsWithAnswers
  response
