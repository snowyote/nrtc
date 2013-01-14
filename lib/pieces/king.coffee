Piece = require '../piece'

module.exports = class King extends Piece
  destinations: (c) ->
    [c.n.w, c.n, c.n.e,
     c.w,          c.e,
     c.s.w, c.s, c.s.e]
