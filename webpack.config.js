/*
 * Refer to the following great tutorials from Pete Hunt:
 * https://github.com/petehunt/react-howto
 * https://github.com/petehunt/webpack-howto
 * http://survivejs.com/webpack/introduction !!!
 */
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  cache: true,
  entry: './src/index.cjsx',
  output: {
    path: './dist',
    filename: 'index.js',
  },

  resolve: {
    // you can now require('file') instead of require('file.coffee')
    extensions: ['', '.js', '.jsx', '.cjsx', '.json', '.coffee']//,
    //modulesDirectories: ['node_modules', 'src/fixtures']
  },

  module: {
    loaders: [
      { test: /\.jsx$/, loader: "jsx-loader?insertPragma=React.DOM" },
      { test: /\.cjsx$/, loaders: ["coffee", "cjsx"] },
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      { test: /\.(png|jpg|gif)$/, loader: 'url-loader?limit=8192&name=/imgs/[name].[ext]' }, // inline base64 URLs for <=8k images, direct URLs for the rest
      { test: /\.ico$/, loader: 'file' },
      { test: /\.json$/, loader: 'json-loader' },
      { test: /\.(eot|ttf|woff|woff2|svg)$/, loader: 'url-loader?limit=50000&name=/fonts/[name].[ext]' } // inline base64 URLs for <=8k images, direct URLs for the rest
    ]
  },

  devServer: {
    // Enable history API fallback so HTML5 History API based routing works. This is a good default that will come in handy in more complicated setups.
    historyApiFallback: true,
    hot: true,
    inline: true,

    quiet: false,
    progress: true,
    colors: true,

    // Display only errors to reduce the amount of output.
    stats: {
      assets: true, modules: false, colors: true, version: false, hash: false, timings: true, chunks: true, chunkModules: false
    },
    // If you use Vagrant or Cloud9, set
    // host: process.env.HOST || '0.0.0.0';
    // 0.0.0.0 is available to all network devices
    // unlike default localhost
    host: process.env.HOST || "127.0.0.1",
    port: process.env.PORT || 8888

    // If you want defaults, you can use a little trick like this
    // port: process.env.PORT || 3000
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      title: "ECB SDMX Web Data Connectors",
      template: "src/indexTpl.ejs",
      xhtml: true
    })    
  ]
};
