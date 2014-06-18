var eco = require('reactive-eco');
var umd = require('umd-wrapper');

function EcoCompiler(config) {
  var plugins = config.plugins;
  if (plugins == null) plugins = {};
  var options = plugins.eco;

  if (options) {
    if (typeof options.overrides === "function") {
      options.overrides(eco);
    }
    this.namespace = options.namespace;
  }
}

EcoCompiler.prototype.brunchPlugin = true;
EcoCompiler.prototype.type = 'template';
EcoCompiler.prototype.extension = 'eco';

EcoCompiler.prototype.compile = function(data, path, callback) {
  var error, key, ns, result, source;
  try {
    source = eco.compile(data).toString();
    result = this.namespace ? (ns = this.namespace, key = path.replace(/^.*templates\//, '').replace(/\..+?$/, ''), "if (typeof " + ns + " === 'undefined'){ " + ns + " = {} }; " + ns + "['" + key + "'] = " + source) : umd(source);
  } catch (err) {
    error = err;
  } finally {
    callback(error, result);
  }
};

module.exports = EcoCompiler;
