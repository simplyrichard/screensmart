var React = require('react')
var ReactDOM = require('react-dom')
var ScreensmartApp = require('./components/screensmart_app')

ReactDOM.render(React.createElement(ScreensmartApp, null, 'bla'),
                document.getElementById('app'))
