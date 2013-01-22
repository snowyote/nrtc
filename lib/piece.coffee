Location = require './location'
Move     = require './move'
Cooldown = require './cooldown'
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

  set_cooldown: (num_ticks) ->
    @cooldown = new Cooldown(num_ticks)

  tick_cooldown: ->
    if @cooldown?.tick()
      @cooldown = null

  remove_from_play: ->
    @location = null

  moves: (from) ->
    return [] if @cooldown
    new Move(from, to) for to in @destinations(from) when to.valid

  valid_move: (move) ->
    return false if @cooldown
    move.to.valid && _.contains @destinations(move.from), move.to

  # pawns use this <3
  in_initial_location: true
