INVALID = null

module.exports = class Cell
  constructor: (@location) ->
    throw new Error("no location provided") unless @location?
    @piece = null
    @valid = false

  wire: (@n, @e, @w, @s) ->
    this[dir] ?= INVALID for dir in ['n', 'e', 'w', 's']
    @valid = true

INVALID = new Cell('invalid')
INVALID[dir] = INVALID for dir in ['n', 'e', 'w', 's']
