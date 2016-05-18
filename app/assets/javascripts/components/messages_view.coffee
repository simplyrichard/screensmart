@MessagesView = React.createClass
  displayName: 'MessagesView'

  render: ->
    {ul, li, div} = React.DOM
    any = @props.messages.length > 0

    if any
      div
        className: 'message-container'
        ul
          className: 'messages'
          @props.messages.map (message, index) ->
            li
              className: 'message'
              key: index
              dangerouslySetInnerHTML: { __html: message }
    else
      null
