Renderer = require './renderer'
DisplayBoard = require './displayboard'
DisplayPiece = require './displaypiece'

module.exports = class DisplayGame
  constructor: (elt) ->
    @renderer = new Renderer(elt)
    @board = new DisplayBoard(@renderer)
