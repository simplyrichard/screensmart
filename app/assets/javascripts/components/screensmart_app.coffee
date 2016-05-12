@ScreensmartApp = React.createClass
  displayName: 'ScreensmartApp'

  componentDidMount: ->
    Screensmart.store.dispatch Screensmart.Actions.updateResponse()

  render: ->
    React.DOM.div
      className: 'app'
      React.createElement MessagesContainer,
        null
      React.createElement FeedContainer,
        null
