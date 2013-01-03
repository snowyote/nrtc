Piece    = require '../lib/piece'
Cell     = require '../lib/cell'
Location = require '../lib/location'
Move     = require '../lib/move'
_        = require 'underscore'

describe 'Piece', ->
  it 'should be abstract', ->
    expect(-> new Piece).to.throw()

# TestPiece can move one square north or south
class TestPiece extends Piece
  destinations: (c) ->
    [c.n, c.s]

describe 'TestPiece', ->
  it 'should construct', ->
    expect(-> new TestPiece).to.not.throw()

  # Here's a tiny, '1-d' board:
  a = new Cell(new Location(0, 0))
  b = new Cell(new Location(0, 1))
  c = new Cell(new Location(0, 2))
  a.wire(null, null, null, b)
  b.wire(a, null, null, c)
  c.wire(b, null, null, null)

  describe 'instance', ->
    instance = new TestPiece
      
    beforeEach ->
      instance.remove_from_play()
      # clear board
      cell.piece = null for cell in [a, b, c]

    it 'should not be in play', ->
      instance.in_play().should.equal false
    it 'should have a null location', ->
      expect(instance.location).to.equal null

    it 'should have destinations', ->
      instance.destinations(a).should.include b
      instance.destinations(b).should.include a
      instance.destinations(b).should.include c
      instance.destinations(c).should.include b

    check_moves = (l, r) ->
      l.length.should.equal r.length
      lm.from.should.equal(rm.from) and lm.to.should.equal(rm.to) for [lm, rm] in _.zip l, r

    it 'should have moves', ->
      check_moves instance.moves(a), [new Move(a, b)]
      check_moves instance.moves(b), [new Move(b, a), new Move(b, c)]
      check_moves instance.moves(c), [new Move(c, b)]
