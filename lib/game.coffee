Board   = require './board'
Pieces  = require './pieces'
Move    = require './move'
_       = require 'underscore'

VELOCITY = 1.0/30.0                  # cells per tick
COOLDOWN = 30*3                      # num ticks

module.exports = class Game
  constructor: (layout) ->
    @board = new Board()

    # omg destructuring-bind... omg...
    @pieces = for {type: typename, location: [x, y]} in layout
      type = Pieces[typename]
      piece = new type()
      @board.at(x,y).piece = piece
      piece.move_to(x,y)
      piece

    @essential_pieces = _.where @pieces, {is_essential: true}
    @victor = null

    @queued_moves = []
    @active_moves = []

  move: (piece, destination_cell) ->
    cell = @board.cell_of(piece)
    if cell && piece.valid_move(new Move(cell, destination_cell))
      @queued_moves.push [piece, destination_cell]

  tick: ->
    # start all queued moves
    for [piece, destination_cell] in @queued_moves
      cell = @board.cell_of(piece)
      if cell && piece.valid_move(new Move(cell, destination_cell))
        cell.piece = null
        @active_moves.push [piece, destination_cell]
        piece.in_initial_location = false
    @queued_moves = []

    # continue all moves in flight
    finished_moves = []
    for move in @active_moves
      [piece, destination_cell] = move
      if piece.location.move_towards(destination_cell.location, VELOCITY)
        captured_piece = destination_cell.piece
        captured_piece.remove_from_play() if captured_piece
        destination_cell.piece = piece
        finished_moves.push move
        piece.set_cooldown COOLDOWN

    # clean up @active_moves, if necessary
    if finished_moves.length > 0
      @active_moves = _.difference @active_moves, finished_moves

    # tick all cooldowns
    piece.tick_cooldown() for piece in @pieces

    # check victory conditions
    p = _.find @essential_pieces, (p) -> not p.in_play()
    if p?
      @victor = if (p.color == 'black') then 'white' else 'black'
      @tick = ->

  create_state: ->
    victor: @victor
    active_moves: _.map @active_moves, _.clone
    current_tick: @current_tick
    cells: for x in [0...8]
      for y in [0...8]
        c = @at(x, y)
        if c.piece then _.indexOf @pieces, c.piece else null
    pieces: for p in @pieces
      [p.location, p.in_initial_location, p.cooldown]

  restore_from_state: (state) ->
    @victor = state.victor
    @active_moves = state.active_moves
    @current_tick = state.current_tick
    for x in [0...8]
      for y in [0...8]
        c = @at(x, y)
        sc = state.cells[x][y]
        c.piece = if sc? then @pieces[sc] else null
    for pi in [0...state.pieces.length]
      p = @pieces[pi]
      [p.location, p.in_initial_location, p.cooldown] = state.pieces[pi]
