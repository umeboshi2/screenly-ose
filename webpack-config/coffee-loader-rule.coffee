coffeeLoaderTranspileRule =
  test: /\.coffee$/
  loader: 'coffee-loader'
  options:
    transpile:
      presets: ['env']
      plugins: ["dynamic-import-webpack"]
    sourceMap: true
    
coffeeLoaderDevRule =
  test: /\.coffee$/
  loader: 'coffee-loader'
  options:
    sourceMap: true

coffeeLoaderRule =
  development: coffeeLoaderDevRule
  production: coffeeLoaderTranspileRule
  
module.exports = coffeeLoaderRule
