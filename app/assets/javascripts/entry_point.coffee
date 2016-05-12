document.addEventListener 'DOMContentLoaded', ->
  store = Screensmart.store = Redux.createStore Screensmart.reducer
  ReactDOM.render React.createFactory(ReactRedux.Provider)(
    store: store
    React.createFactory(ScreensmartApp)({})
  ), document.getElementById('root')
