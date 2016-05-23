merge = (objects...) ->
  $.extend {}, objects...

deepCopy = (originalObject) ->
  $.extend(true, {}, originalObject)

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
        updatedResponse = responseWithoutNonFilledOutQuestions(
          responseWithAnswer(
            response,
            action.key,
            action.value
          )
        )

        merge updatedResponse,
              loading: true

      when 'RECEIVE_RESPONSE_UPDATE'
        merge response,
              action.response,
              loading: false

      else
        questions: []
        loading: true
        done: false

responseWithAnswer = (oldResponse, key, value) ->
  response = deepCopy oldResponse
  index = indexOfQuestion(response, key)
  response.questions[index].answer_value = value
  response

indexOfQuestion = (response, key) ->
  response.questions.indexOf questionByKey(response, key)

questionByKey = (response, key) ->
  response.questions.filter((question) ->
    question.key == key
  )[0]

responseWithoutNonFilledOutQuestions = (oldResponse) ->
  response = deepCopy oldResponse
  questionsWithAnswers = response.questions.filter (question) ->
    question.answer_value?
  response.questions = questionsWithAnswers
  response
