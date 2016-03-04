describe 'ScreensmartApp', ->
  beforeEach ->
    @questions = fixture.preload('questions.json')[0]

  it 'initially shows a div with the first question', ->
    expect(@questions[0].key).toBe('EL02')

    initialQuestions = [
      key: 'EL02'
      text: "De tijd lijkt onnatuurlijk veel sneller of langzamer te gaan dan anders."
      answerOptionSet: [
        { value: 0, text: 'Oneens' },
        { value: 1, text: 'Eens' },
      ],
      answer: null
    ]

    app = React.createElement ScreensmartApp,
      backend: 'demo.roqua.dev:3000'
      questions: @questions
      initialResponse:
        estimate: 1.0
        variance: 0.5
        questions: initialQuestions

    expect React.addons.TestUtils.createRenderer().render(app), 'to have rendered with children',
      React.createElement QuestionList, questions: initialQuestions
