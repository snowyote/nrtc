Game     = require '../lib/game'
Location = require '../lib/location'

TEST_LAYOUT = [{type: 'BlackRook', location: [1, 1]}]

describe 'Game', ->
  instance = null
  rook = null
  beforeEach ->
    instance = new Game(TEST_LAYOUT)
    rook = instance.pieces[0]

  describe '#move', ->

    it 'should queue a move', ->
      dest = instance.board.at(8, 1)
      instance.move rook, dest
      instance.move_history[0].should.deep.equal [[rook, dest]]

    it 'should order the move queue', ->
      instance.move rook, instance.board.at(8, 1)
      instance.move rook, instance.board.at(1, 8)
      first_try = instance.move_history[0]
      instance.move_history[0] = undefined

      instance.move rook, instance.board.at(1, 8)
      instance.move rook, instance.board.at(8, 1)
      second_try = instance.move_history[0]
      instance.move_history[0] = undefined

      first_try.should.deep.equal second_try

  describe '#tick', ->

    it 'should activate moves', ->
      dest = instance.board.at(8, 1)
      instance.move rook, dest
      instance.tick()
      instance.active_moves.should.deep.equal [[rook, dest]]

    it 'should not activate invalid moves', ->
      dest = instance.board.at(4, 3)
      instance.move rook, dest
      instance.tick()
      instance.active_moves.should.deep.equal []
