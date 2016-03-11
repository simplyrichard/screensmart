{div, h1, p} = React.DOM

@ScreensmartApp = React.createClass
  displayName: 'ScreensmartApp'

  getInitialState: ->
    response: @props.initialResponse

  questionByKey: (key) ->
    @state.response.questions.find((question) ->
      question.key == key
    )

  addAnswerToQuestion: (key, value) ->
    response = @state.response
    questions = response.questions
    question_index = questions.indexOf(@questionByKey(key))
    response.questions[question_index].answer = value
    @setState(response: response)

  questionsWithAnswer: ->
    @state.response.questions.filter (question) ->
      question.answer?

  answerHash: ->
    answers = {}
    @questionsWithAnswer().forEach (question) ->
      answers[question.key] = question.answer
    answers

  refreshResponse: ->
    $.ajax '/responses',
      method: 'POST'
      dataType: 'json'
      data:
        answers:  @answerHash()
        old_estimate: @state.response.estimate
        old_variance: @state.response.variance
      headers:
        'X-CSRF-Token': @props.csrfToken
    .fail (xhr, status, errorThrown) ->
      console.log("Failure: #{status}, #{errorThrown}")
    .done (data) =>
      @setState(response: data.response)

  onAnswerChange: (key, value) ->
    @addAnswerToQuestion(key, value)
    @refreshResponse()

  render: ->
    div
      className: 'app'
      h1
        className: 'application-name'
        'screensmart'
      p
        className: 'estimate'
        "estimate: #{@state.response.estimate}"
      p
        className: 'variance'
        "variance: #{@state.response.variance}"
      React.createElement QuestionList, onAnswerChange: @onAnswerChange, questions: @state.response.questions
