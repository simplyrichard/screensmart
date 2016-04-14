var config = module.exports = require('./base.config.js');
var path = require('path');
var ChunkManifestPlugin = require('chunk-manifest-webpack-plugin');
var webpack = require('webpack');


config.output.path = path.join(config.context, 'public', 'assets');
config.output.filename = '[name]-bundle-[chunkhash].js';
config.output.chunkFilename = '[id]-bundle-[chunkhash].js';

config.plugins.push(
  new webpack.optimize.CommonsChunkPlugin('common', 'common-[chunkhash].js'),
  new ChunkManifestPlugin({
    filename: 'webpack-common-manifest.json',
    manifestVariable: 'webpackBundleManifest'
  }),
  new webpack.optimize.UglifyJsPlugin({
    compress: { warnings: false }
  }),
  new webpack.optimize.OccurenceOrderPlugin()
);
