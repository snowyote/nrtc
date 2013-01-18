Piece = require '../piece'

module.exports = class WalkingPiece extends Piece
  walk: (c, dirs, ax) ->
    for dir in dirs
      c = c[dir]
    return unless c.valid
    return if c.piece && c.piece.color == @color
    ax.push c
    return if c.piece
    @walk(c, dirs, ax)
