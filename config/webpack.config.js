const path = require('path');
const webpack = require('webpack');

const DIR_SOURCE = path.join(__dirname, '..', 'source');
const DIR_BUILD = path.resolve(__dirname, '..', 'build');
const DIR_WEBROOT = path.resolve(__dirname, '..', 'public');

let config = {
  devServer: {
    contentBase: DIR_WEBROOT,
    compress: false,
    historyApiFallback: true,
    hot: true,
    noInfo: false
  },
  entry: path.join(DIR_SOURCE, 'entry.js'),
  module: {
    rules: [

    ]
  },
  output: {
    path: DIR_BUILD,
    filename: 'output.js'
  },

  performance: {
    hints: 'warning'
  },
  plugins: [

  ],
  target: 'web'
};

module.exports = config;

