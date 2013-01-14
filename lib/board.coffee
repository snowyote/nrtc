Cell = require './cell'

module.exports = class Board
  constructor: ->
    g = for x in [0...10]
      for y in [0...10]
        null
    for x in [1..8]
      for y in [1..8]
        g[x][y] = new Cell(x, y)
    for x in [1..8]
      for y in [1..8]
        g[x][y].wire(g[x][y-1], g[x+1][y], g[x-1][y], g[x][y+1])
    @grid = g

  at: (x, y) -> @grid[x][y]
