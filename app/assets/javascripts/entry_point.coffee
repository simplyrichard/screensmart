document.addEventListener 'DOMContentLoaded', ->
  store = Screensmart.store = Redux.createStore \
    Screensmart.reducer,
    Redux.applyMiddleware(Redux.thunk)

  store.dispatch Screensmart.Actions.updateResponse()

  provider = React.createFactory(ReactRedux.Provider)
    store: store,
    React.createFactory(ScreensmartApp)({})

  ReactDOM.render provider, document.getElementById('root')
