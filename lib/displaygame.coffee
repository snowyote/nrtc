Renderer = require './renderer'
Game = require './game'
DisplayBoard = require './displayboard'
Layouts = require './layouts'
Pieces = require './pieces'
Location = require './location'

module.exports = class DisplayGame
  constructor: (elt) ->
    @game = new Game(Layouts.traditional)
    @renderer = new Renderer(elt)
    @board = new DisplayBoard(@renderer)
    window.setInterval @draw, 66 #30fps

    elt.addEventListener 'mousemove', (evt) =>
      rect = elt.getBoundingClientRect()
      [x, y] = [evt.clientX - rect.left, evt.clientY - rect.top]
      [x, y] = @renderer.boardspace(x, y)
      x = Math.max(Math.min(Math.round(x), 8), 1)
      y = Math.max(Math.min(Math.round(y), 8), 1)
      @location = new Location(x, y)
    elt.addEventListener 'mouseout', (evt) =>
      @location = null

  draw: () =>
    @game.tick()                # this should be separated, but
    @board.draw()
    for p in @game.pieces
      if p.in_play()
        @renderer.image p.location.x, p.location.y, p.img
