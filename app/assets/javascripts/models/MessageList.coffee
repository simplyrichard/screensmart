class @MessageList
  constructor: (view) ->
    @view = view
    @messages = []

  push: (message) ->
    @messages.push(message)
