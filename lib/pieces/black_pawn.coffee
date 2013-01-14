Pawn = require './pawn'

module.exports = class BlackPawn extends Piece
  color: 'black'
  destinations: (c) -> [c.s]
  