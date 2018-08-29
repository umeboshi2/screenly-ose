BuildEnvironment = process.env.NODE_ENV or 'development'
if BuildEnvironment not in ['development', 'production']
  throw new Error "Undefined environment #{BuildEnvironment}"
module.exports = BuildEnvironment

