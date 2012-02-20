eco = require 'eco'

module.exports = class EcoCompiler
  compilerType: 'template'
  extension: 'eco'

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      result = "module.exports = #{eco.compile data}"
    catch err
      error = err
    callback error, result
