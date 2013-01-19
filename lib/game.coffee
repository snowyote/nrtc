Board   = require './board'
Pieces  = require './pieces'
Move    = require './move'
_       = require 'underscore'

VELOCITY = 1.0/30.0                  # cells per tick

module.exports = class Game
  constructor: (layout) ->
    @board = new Board()
    @pieces = for [x, y, typename] in layout
      type = Pieces[typename]
      piece = new type()
      @board.at(x,y).piece = piece
      piece.move_to(x,y)
      piece
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

    # clean up @active_moves, if necessary
    if finished_moves.length > 0
      @active_moves = _.difference @active_moves, finished_moves
