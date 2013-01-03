_ = require 'underscore'

module.exports =
  observe: (object, name, func) ->
    unless object[name].__OBSERVED_HOOKS__?
      wrapper = (args...) ->
        func.call(this, args...) for func in wrapper.__OBSERVED_HOOKS__
        wrapper.__OBSERVED_ORIG__.call(this, args...)
      wrapper.__OBSERVED_ORIG__ = object[name]
      wrapper.__OBSERVED_HOOKS__ = []
      object[name] = wrapper
    object[name].__OBSERVED_HOOKS__.push func
    
  unobserve: (object, name, optional_func) ->
    if optional_func
      object[name].__OBSERVED_HOOKS__ =
        _.without(object[name].__OBSERVED_HOOKS__, optional_func)
    else
      object[name].__OBSERVED_HOOKS__.pop()
    if object[name].__OBSERVED_HOOKS__.length == 0
      object[name] = object[name].__OBSERVED_ORIG__
