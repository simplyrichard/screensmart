onAnswerChange = (response, key, value) ->
  Screensmart.store.dispatch Screensmart.Actions.setAnswer(response, key, value)

mapStateToProps = (state) ->
  children: new FeedBuilder(
    response: state.response,
    onAnswerChange: onAnswerChange
  ).getReactComponents()

mapDispatchToProps = (dispatch) ->
  {}

@FeedContainer = ReactRedux.connect(
  mapStateToProps,
  mapDispatchToProps)(FeedView)
