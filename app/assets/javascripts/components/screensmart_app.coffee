@ScreensmartApp = React.createClass
  render: ->
    React.createElement QuestionList, questions: @props.questions
