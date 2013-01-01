INVALID = { valid: false }

module.exports = class Cell
  constructor: (@location) ->
    throw new Error("no location provided") unless @location?
    @valid = false

  wire: (@n, @e, @w, @s) ->
    @n ?= INVALID
    @e ?= INVALID
    @w ?= INVALID
    @s ?= INVALID
    @valid = true


