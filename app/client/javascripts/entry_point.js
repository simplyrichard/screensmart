require('es5-shim')
require('es5-shim/es5-sham')
var React = require('react')
var ReactDOM = require('react-dom')
var ScreensmartApp = require('./components/screensmart_app')

ReactDOM.render(React.createElement(ScreensmartApp, null, 'bla'),
                document.getElementById('app'))
