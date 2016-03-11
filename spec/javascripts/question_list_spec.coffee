describe 'QuestionList', ->
  it 'lists the answers', ->
    initialQuestions = [
      key: 'EL02'
      text: "De tijd lijkt onnatuurlijk veel sneller of langzamer te gaan dan anders."
      answerOptionSet: [
        { value: 0, text: 'Oneens' },
        { value: 1, text: 'Eens' },
      ],
      answer: null
    ]

    element = React.createElement QuestionList,
      questions: initialQuestions

    expect React.addons.TestUtils.createRenderer().render(element), 'to have rendered with children',
      React.createElement QuestionList
