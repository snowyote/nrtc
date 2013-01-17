Piece = require '../piece'

module.exports = class BlackPawn extends Piece
  color: 'black'
  destinations: (c) -> [c.s]
  img: 'img/black_pawn.png'
  