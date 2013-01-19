Piece = require '../piece'

# @TODO can move two spaces forward iff in initial position
module.exports = class Pawn extends Piece
  destinations: (c) ->
    rv = []
    forward = c[@primary_direction]
    unless forward.piece?
      rv.push forward
      if @in_initial_location
        double_forward = forward[@primary_direction]
        rv.push double_forward unless double_forward.piece?
    possibly = (c) -> rv.push c if c.piece? && c.piece.color != @color
    possibly forward.e
    possibly forward.w
    return rv
