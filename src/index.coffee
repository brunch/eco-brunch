eco = require 'eco'

module.exports = class EcoCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'eco'

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      result = eco.compile(data).toString()
    catch err
      error = err
    callback error, result
