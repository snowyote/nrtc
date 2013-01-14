WalkingPiece = require './walking_piece'

module.exports = class Queen extends WalkingPiece
  destinations: (c) ->
    rv = []
    walk(c, dir, rv) for dir in [['n'], ['e'], ['w'], ['s'], ['n', 'e'], ['s', 'e'], ['n', 'w'], ['s', 'w']]
    rv
