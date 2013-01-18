WalkingPiece = require '../../lib/pieces/walking_piece'
Location     = require '../../lib/location'
Board        = require '../../lib/board'

class TestWalkingPiece extends WalkingPiece
  destinations: (c) ->
    rv = []
    @walk(c, ['n'], rv)
    rv
  color: 'beige'

describe 'WalkingPiece', ->
  board = null
  piece = null
  beforeEach ->
    board = new Board()
    piece = new TestWalkingPiece()
    piece.move_to(4, 6)
    board.at(4, 6).piece = piece

  it 'should walk to generate destinations', ->
    dests = piece.destinations(board.atloc(piece.location))
    dests.should.include(board.at(4, 1))
    dests.should.include(board.at(4, 5))
    dests.should.not.include(board.at(4, 8))

  it 'should be blocked by same-team pieces', ->
    friend = new TestWalkingPiece()
    friend.move_to(4,3)
    board.at(4,3).piece = friend
    dests = piece.destinations(board.atloc(piece.location))
    dests.should.include(board.at(4, 4))
    dests.should.not.include(board.at(4, 3))
    dests.should.not.include(board.at(4, 2))
