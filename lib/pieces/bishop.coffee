WalkingPiece = require './walking_piece'

module.exports = class Bishop extends WalkingPiece
  destinations: (c) ->
    rv = []
    walk(c, dir, rv) for dir in [['n', 'e'], ['s', 'e'], ['n', 'w'], ['s', 'w']]
    rv
