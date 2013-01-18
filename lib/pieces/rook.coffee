WalkingPiece = require './walking_piece'

module.exports = class Rook extends WalkingPiece
  destinations: (c) ->
    rv = []
    @walk(c, dir, rv) for dir in [['n'], ['e'], ['w'], ['s']]
    rv
