@MessagesView = React.createClass
  displayName: 'MessagesView'

  render: ->
    {ul, li} = React.DOM

    ul
      className: 'messages'
      @props.messages.map (message, index) ->
        li
          className: 'message'
          key: index
          dangerouslySetInnerHTML: { __html: message }
