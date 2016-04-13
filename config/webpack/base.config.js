var path = require('path');
var webpack = require('webpack');

var config = module.exports = {
  context: path.join(__dirname, '../', '../'),
  entry: './app/client/javascripts/entry_point.js',

  output: {
    path: './app/assets/javascripts',
    filename: 'bundle.js',
    publicPath: '/assets'
  },

  resolve: {
    extensions: ['', '.coffee', '.js']
  },

  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
    ]
  },

  plugins: [],
};
