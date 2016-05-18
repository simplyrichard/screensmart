mapStateToProps = (state) ->
  state

mapDispatchToProps = (dispatch) ->
  {}

@MessagesContainer = ReactRedux.connect(
  mapStateToProps,
  mapDispatchToProps)(MessagesView)
