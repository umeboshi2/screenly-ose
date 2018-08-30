path = require 'path'
webpack = require 'webpack'

# BuildEnvironment should either be 'development' or 'production'
BuildEnvironment = require './webpack-config/buildenv'

# plugins
MiniCssExtractPlugin = require 'mini-css-extract-plugin'
FaviconPlugin = require 'favicons-webpack-plugin'
StatsPlugin = require 'stats-webpack-plugin'
HtmlPlugin = require 'html-webpack-plugin'

# rules
coffeeLoaderRule = require './webpack-config/coffee-loader-rule'
buildCssLoader = require './webpack-config/sass-loader-chain'
woffRule = require './webpack-config/woff-rule'
imgVersionedRule = require './webpack-config/img-file-loader-versioned'


DefinePluginOpts =
  development:
    __DEV__: 'true'
    DEBUG: JSON.stringify(JSON.parse(process.env.DEBUG || 'false'))
    #__useCssModules__: 'true'
    __useCssModules__: 'false'
  production:
    __DEV__: 'false'
    DEBUG: 'false'
    #__useCssModules__: 'true'
    __useCssModules__: 'false'
    'process.env':
      'NODE_ENV': JSON.stringify 'production'
    
# handles output filename for js and css
outputFilename = (ext) ->
  d = "[name].#{ext}"
  p = "[name]-[chunkhash].#{ext}"
  return
    development: d
    production: p
    
# set output filenames
WebPackOutputFilename = outputFilename 'js'
CssOutputFilename = outputFilename 'css'

# path to build directory
localBuildDir =
  development: "dist"
  production: "dist"

WebPackOutput =
  filename: WebPackOutputFilename[BuildEnvironment]
  path: path.join __dirname, localBuildDir[BuildEnvironment]
  globalObject: 'self'
  

# parse "entrypoints.json" on web server backend
# to inject entry points into html
entryPointsManifest = new StatsPlugin 'entrypoints.json',
  assets: false
  cached: false
  cachedAssets: false
  children: false
  chunks: false
  chunkModules: false
  chunkOrigins: false
  entrypoints: true
  modules: false
  reasons: false
  source: false


commonPlugins = [
  new webpack.DefinePlugin DefinePluginOpts[BuildEnvironment]
  new StatsPlugin 'stats.json',
    chunkModules: true
    source: false
  entryPointsManifest
  new MiniCssExtractPlugin
    filename: CssOutputFilename[BuildEnvironment]
  new FaviconPlugin
    logo: './static/favicons/screenly-from-inkscape.svg'
    title: 'Screenly-OSE'
    icons:
      android: false
      appleIcon: false
      appleStartup: false
      favicons: true
      firefox: false
      opengraph: false
      twitter: false
      yandex: false
      windows: false
  new HtmlPlugin
    template: './client/index-page.coffee'
    filename: 'index.html'
    entryPoint: 'index'
    inject: true
  ]


extraPlugins = []



loadCssRule =
  test: /\.css$/
  use: ['style-loader', 'css-loader']


WebPackConfig =
  devtool: 'source-map'
  mode: BuildEnvironment
  entry:
    index: './client/index.coffee'
  output: WebPackOutput
  plugins: commonPlugins
  module:
    rules: [
      loadCssRule
      {
        test: /\.scss$/
        use: buildCssLoader[BuildEnvironment]
      }
      coffeeLoaderRule[BuildEnvironment]
      woffRule
      imgVersionedRule
     ]
  resolve:
    extensions: [".wasm", ".mjs", ".js", ".json", ".coffee"]

if BuildEnvironment is 'development'
  WebPackConfig.devtool = 'source-map'
  WebPackConfig.watch = true
  WebPackConfig.watchOptions =
    ignored: [
      'node_modules'
      '^\/.#'
    ]
  WebPackConfig.devServer =
    host: 'localhost'
    #host: '0.0.0.0'
    disableHostCheck: true
    port: 8082
    #index: './templates/index.html'
    index: 'templates/index.html'
    historyApiFallback: true
    # cors for using a server on another port
    headers: {"Access-Control-Allow-Origin": "*"}
    proxy:
      '/api/*': 'http://localhost:8080'
      '/static/*': 'http://localhost:8080'
    stats:
      colors: true
      modules: false
      chunks: true
      
module.exports = WebPackConfig
