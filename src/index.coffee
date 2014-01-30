eco = require 'eco'
umd = require 'umd-wrapper'

module.exports = class EcoCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'eco'

  constructor: (@config) ->
    ecoConfig = @config.plugins?.eco
    if ecoConfig
      ecoConfig.overrides?(eco)
      @namespace = ecoConfig.namespace


  compile: (data, path, callback) ->
    try
      source = eco.compile(data).toString()
      result = 
        if @namespace
          ns = @namespace
          key = path.replace(/^.*templates\//, '').replace(/\..+?$/, '')
          "if (typeof #{ns} === 'undefined'){ #{ns} = {} }; #{ns}['#{key}'] = #{source}"
        else
          umd source

    catch err
      error = err
    callback error, result

