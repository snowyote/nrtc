Board   = require './board'
Pieces  = require './pieces'

module.exports = class Game
  constructor: (layout) ->
    @board = new Board()
    @pieces = for [x, y, typename] in layout
      type = Pieces[typename]
      piece = new type()
      @board.at(x,y).piece = piece
      piece.move_to(x,y)
      piece
    
