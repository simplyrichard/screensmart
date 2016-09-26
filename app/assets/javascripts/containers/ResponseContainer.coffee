mapStateToProps = (state) ->
  response: state.response

@ResponseContainer = ReactRedux.connect(
  mapStateToProps
)(ResponseView)
