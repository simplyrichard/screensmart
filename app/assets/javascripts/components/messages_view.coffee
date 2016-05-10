@MessagesView = React.createClass
  displayName: 'MessagesView'

  propTypes:
    messages: React.PropTypes.array.isRequired

  render: ->
    {ul, li} = React.DOM

    ul
      className: 'messages'
      @props.messages.map (message, index) ->
        li
          className: 'message'
          key: index
          dangerouslySetInnerHTML: { __html: message }
