Location = require './location'

module.exports = class Piece
  constructor: ->
    @location = null
    throw new Error "Please implement destinations" unless @destinations?

  in_play: ->
    @location?

  move_to: (x, y) ->
    @location = new Location(x, y)

  remove_from_play: ->
    @location = null
    