Game     = require '../lib/game'
Location = require '../lib/location'

TEST_LAYOUT = [{type: 'BlackRook', location: [1, 1]}, {type: 'WhiteQueen', location: [6, 2]}]

describe 'Game', ->
  instance = null
  rook = null
  queen = null
  beforeEach ->
    instance = new Game(TEST_LAYOUT)
    rook = instance.pieces[0]
    queen = instance.pieces[1]

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

  describe '#index_of_piece', ->
    it 'should return the index of a piece', ->
      instance.index_of_piece(rook).should.equal 0
      instance.index_of_piece(queen).should.equal 1
  describe '#piece_of_index', ->
    it 'should return the piece given its index', ->
      instance.piece_of_index(0).should.equal rook
      instance.piece_of_index(1).should.equal queen

  describe '#index_of_cell', ->
    it 'should return the index of a cell', ->
      instance.index_of_cell(instance.board.cell_of(rook)).should.equal 0
      instance.index_of_cell(instance.board.cell_of(queen)).should.equal 13
  describe '#cell_of_index', ->
    it 'should return the cell given its index', ->
      instance.cell_of_index(0).should.equal(instance.board.cell_of(rook))
      instance.cell_of_index(13).should.equal(instance.board.cell_of(queen))

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

    it 'should rewind when old moves have arrived', ->
      instance.tick()

      instance.move rook, instance.board.at(8, 1)
      instance.tick()
      instance.current_tick.should.equal 2
      instance.active_moves.should.deep.equal [[rook, instance.board.at(8, 1)]]

      instance.move rook, instance.board.at(1, 8), 0
      instance.tick()
      instance.current_tick.should.equal 3
      instance.active_moves.should.deep.equal [[rook, instance.board.at(1, 8)]]
