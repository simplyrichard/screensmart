{div, i, p} = React.DOM
@LoadingIndicator = React.createClass
  displayName: 'LoadingIndicator'

  render: ->
    div
      className: 'loading-indicator'
      p
        className: 'text'
        'Laden ...'
