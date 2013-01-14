Piece = require '../piece'

module.exports = class WhitePawn extends Piece
  color: 'white'
  destinations: (c) -> [c.n]
  