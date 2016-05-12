mapStateToProps = (state) ->
  state

mapDispatchToProps = (dispatch) ->
  return {}

@MessagesContainer = ReactRedux.connect(
  mapStateToProps,
  mapDispatchToProps)(MessagesView)
