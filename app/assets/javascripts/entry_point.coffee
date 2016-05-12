document.addEventListener 'DOMContentLoaded', ->
  store = Screensmart.store = Redux.createStore Screensmart.reducer
  store.dispatch Screensmart.Actions.updateResponse()
  ReactDOM.render React.createFactory(ReactRedux.Provider)(
    store: store
    React.createFactory(ScreensmartApp)({})
  ), document.getElementById('root')
