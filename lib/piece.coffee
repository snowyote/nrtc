Location = require './location'
Move     = require './move'
_        = require 'underscore'

module.exports = class Piece
  constructor: ->
    @location = null
    throw new Error "Please implement destinations" unless @destinations?
    throw new Error "Please implement color" unless @color?

  in_play: ->
    @location?

  move_to: (x, y) ->
    @location = new Location(x, y)

  remove_from_play: ->
    @location = null

  moves: (from) ->
    new Move(from, to) for to in @destinations(from) when to.valid

  valid_move: (move) ->
    move.to.valid && _.contains @destinations(move.from), move.to

  # pawns use this <3
  in_initial_location: true
