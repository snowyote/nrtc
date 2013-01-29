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
    new Move(from, to) for to in @destinations(from) when @valid_destination to

  valid_destination: (dest) ->
    (not @cooldown?) && dest.valid && (not dest.piece? or dest.piece.color != @color)

  valid_move: (move) ->
    return @valid_destination(move.to) && _.contains @destinations(move.from), move.to

  # pawns use this <3
  in_initial_location: true

  create_state: ->
    loc = if @location? then [@location.x, @location.y] else null
    cd = if @cooldown? then [@cooldown.initial, @cooldown.ticks_remaining] else null
    [loc, @in_initial_location, cd]

  restore_from_state: (state) ->
    @location = if state[0]? then new Location(state[0][0], state[0][1]) else null
    @in_initial_location = state[1]
    @cooldown = if state[2]? then new Cooldown(state[2][0], state[2][1]) else null
