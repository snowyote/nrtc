Game     = require '../lib/game'
Location = require '../lib/location'

TEST_LAYOUT = [[1, 1, 'BlackRook']]

describe 'Game', ->
  instance = null
  rook = null
  beforeEach ->
    instance = new Game(TEST_LAYOUT)
    rook = instance.pieces[0]

  describe '#move', ->
    it 'should queue a valid move', ->
      dest = instance.board.at(8, 1)
      instance.move rook, dest
      instance.queued_moves.should.deep.equal [[rook, dest]]
    it 'should not queue invalid moves', ->
      dest = instance.board.at(2, 3)
      instance.move rook, dest
      instance.queued_moves.length.should.equal 0

  describe '#tick', ->
    it 'should activate moves', ->
      dest = instance.board.at(8, 1)
      instance.move rook, dest
      instance.tick()
      instance.queued_moves.length.should.equal 0
      instance.active_moves.should.deep.equal [[rook, dest]]
