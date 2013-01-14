Piece = require '../piece'

module.exports = class WalkingPiece extends Piece
  walk: (c, dirs, ax) ->
    c = c[dir] for dir in dirs
    return unless c.valid
    return if c.piece && c.piece.color == @color
    ax.push c
    return if c.piece
    walk(c, dir, ax)
