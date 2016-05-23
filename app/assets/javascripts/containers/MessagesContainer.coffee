mapStateToProps = (state) ->
  state

@MessagesContainer = ReactRedux.connect(
  mapStateToProps)(MessagesView)
