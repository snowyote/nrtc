Cell     = require './cell'
Location = require './location'

module.exports = class Board
  constructor: ->
    g = for x in [0..9]
      for y in [0..9]
        null
    for x in [1..8]
      for y in [1..8]
        g[x][y] = new Cell(new Location(x, y))
    for x in [1..8]
      for y in [1..8]
        g[x][y].wire(g[x][y-1], g[x+1][y], g[x-1][y], g[x][y+1])
    @grid = g

  at: (x, y) -> @grid[x][y]

  atloc: (loc) -> @at(loc.x, loc.y)

  cell_of: (piece) ->
    return null unless piece.in_play()
    cell = @at(piece.location.x, piece.location.y)
    return null unless cell.piece == piece
    return cell
