Board = require '../lib/board'

describe 'Board', ->
  board = null
  beforeEach -> board = new Board()

  it 'should have a border', ->
    for xy in [1..8]
      expect(board.at(xy, 0)).to.equal null
      expect(board.at(xy, 9)).to.equal null
      expect(board.at(0, xy)).to.equal null
      expect(board.at(9, xy)).to.equal null

  it 'should have a body', ->
    for x in [1..8]
      for y in [1..8]
        board.at(x, y).valid.should.equal true

  describe '#atloc', ->
    it 'should work', ->
      board.at(3,4).should.equal board.atloc({x:3,y:4})

  describe '#cell_of', ->
    it 'should work', ->
      cell = board.at(3,4)
      piece = {location:{x:3,y:4},in_play:->true}
      cell.piece = piece
      board.cell_of(piece).should.equal cell

    it 'should not work if the piece is still in-flight', ->
      cell = board.at(3,4)
      piece = {location:{x:3,y:4},in_play:->true}
      expect(board.cell_of(piece)).to.equal null

    it 'should not throw if the piece is non-integral location', ->
      piece = {location:{x:3.14,y:4.8},in_play:->true}
      expect(-> board.cell_of(piece)).to.not.throw()
