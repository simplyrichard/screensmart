onAnswerChange = (key, value) ->
  Screensmart.store.dispatch Screensmart.Actions.setAnswer(key, value)

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
