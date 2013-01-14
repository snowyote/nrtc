Pawn = require './pawn'

module.exports = class WhitePawn extends Pawn
  color: 'white'
  destinations: (c) -> [c.n]
  