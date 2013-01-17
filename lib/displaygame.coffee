Renderer = require './renderer'
Game = require './game'
DisplayBoard = require './displayboard'
DisplayPiece = require './displaypiece'
Layouts = require './layouts'
Pieces = require './pieces'

module.exports = class DisplayGame
  constructor: (elt) ->
    @game = new Game(Layouts.traditional)
    @renderer = new Renderer(elt)
    @board = new DisplayBoard(@renderer)
    @pieces = new DisplayPiece(piece) for piece in @game.pieces
    f = =>
      @board.draw()
      for p in @game.pieces
        if p.in_play()
          @renderer.image p.location.x, p.location.y, p.img
    window.setInterval f, 66
