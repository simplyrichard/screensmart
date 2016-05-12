@ScreensmartApp = React.createClass
  displayName: 'ScreensmartApp'

  render: ->
    React.DOM.div
      className: 'app'
      React.createElement MessagesContainer,
        null
      React.createElement FeedContainer,
        null
