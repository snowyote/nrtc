Piece = require '../piece'

module.exports = class Knight extends Piece
  destinations: (c) ->
    [c.n.n.w, c.n.n.e,
    c.e.e.n, c.e.e.s,
    c.s.s.e, c.s.s.w,
    c.w.w.s, c.w.w.n]
