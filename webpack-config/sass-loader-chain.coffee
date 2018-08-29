MiniCssExtractPlugin = require 'mini-css-extract-plugin'

sassOptions =
  includePaths: [
    'node_modules/compass-mixins/lib'
    'node_modules/bootstrap/scss'
  ]
    
devCssLoader = [
  {
    loader: 'style-loader'
  },{
    loader: 'css-loader'
  },{
    loader: 'sass-loader'
    options: sassOptions
  }
]


miniCssLoader =
  [
    MiniCssExtractPlugin.loader
    {
      loader: 'css-loader'
      options:
        minimize:
          safe: true
    #},{
    #  loader: 'postcss-loader'
    #  options:
    #    autoprefixer:
    #      browsers: ["last 2 versions"]
    #    plugins: () =>
    #      [ autoprefixer ]
    },{
      loader: "sass-loader"
      options: sassOptions
    }
  ]

module.exports =
  development: devCssLoader
  production: miniCssLoader
