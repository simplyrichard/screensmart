describe 'ScreensmartApp', ->
  it 'initially shows a div with the first question', ->
    initialResponse = fixture.load('initial_response.json')[0]
    app = React.createElement ScreensmartApp,
      backend: 'demo.roqua.dev:3000'
      initialResponse: initialResponse

    renderer = React.addons.TestUtils.createRenderer()
    renderer.render(app)
    rendered = renderer.getRenderOutput()
    expect(rendered.type).toBe('div')
    expect(rendered.props.children).toEqual([
      React.DOM.h1 null, 'screensmart'
      React.createElement QuestionList, questions: initialResponse.questions
    ])
