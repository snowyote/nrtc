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
    elt.addEventListener 'mousedown', (evt) =>
      @draggedpiece = @game.board.atloc(@location).piece
    elt.addEventListener 'mouseup', (evt) =>
      @game.move @draggedpiece, @game.board.atloc(@location)
      @draggedpiece = null

  draw: () =>
    @game.tick()                # this should be separated, but
    @board.draw()
    for p in @game.pieces
      if p.in_play()
        @renderer.image p.location.x, p.location.y, p.img
      unless p?
        console.log("Got a null p: #{p}")
      unless @game.board.cell_of(p)?
        console.log("p is at #{p.location}")
    if @draggedpiece? && @location?
      move = {from: @game.board.cell_of(@draggedpiece), to: @game.board.atloc(@location)}
      if @draggedpiece.valid_move(move)
        @renderer.image @location.x, @location.y, @draggedpiece.img, 0.5
