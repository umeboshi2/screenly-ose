path = require 'path'
webpack = require 'webpack'

MiniCssExtractPlugin = require 'mini-css-extract-plugin'
FaviconPlugin = require 'favicons-webpack-plugin'


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

