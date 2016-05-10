@ScreensmartApp = React.createClass
  displayName: 'ScreensmartApp'

  propTypes:
    csrfToken: React.PropTypes.string.isRequired

  componentWillMount: ->
    window.onerror = =>
      @setState messages: @state.messages.concat(['Onbekende fout. Mail naar <a href="mailto:support@roqua.nl">support@roqua.nl</a> voor hulp'])

    @setState
      response: new Response(this)
      messages: []

  showMessage: (message) ->
    @setState messages: @state.messages.concat([message])

  render: ->
    {estimate, variance, questions, done} = @state.response
    {div, h1, p} = React.DOM

    div
      className: 'container'
      div
        className: 'debug'
        div
          className: 'estimate'
          "estimate: #{estimate}"
        div
          className: 'variance'
          "variance: #{variance}"
      React.createElement MessagesView,
        messages: @state.messages
      React.createElement FeedView,
        null
        new FeedBuilder(@state.response).getReactComponents()
