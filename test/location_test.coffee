Location = require '../lib/location'

describe 'Location', ->

  it 'should not construct without 2 args', ->
    expect(-> new Location).to.throw()

  it 'should construct with 2 args', ->
    expect(-> new Location(0,0)).not.to.throw()

  describe 'instance', ->
    instance = null

    beforeEach -> instance = new Location(1,2)

    it 'should return its x-coordinate on .x', ->
      instance.x.should.equal 1

    it 'should return its y-coordinate on .y', ->
      instance.y.should.equal 2

    it 'should assign', ->
      instance.gets(new Location(3,4))
      instance.x.should.equal 3
      instance.y.should.equal 4

  describe 'move_towards', ->
    instance = null
    other = null

    beforeEach ->
      instance = new Location(1,1)
      other = new Location(1,2)

    describe 'partway', ->
      rv = null
      beforeEach ->
        rv = instance.move_towards(other, 0.5)
      it 'should move in the direction provided', ->
        instance.x.should.equal 1
        instance.y.should.equal 1.5
      it 'should return false', ->
        rv.should.equal false

    describe 'exact move', ->
      rv = null
      beforeEach ->
        rv = instance.move_towards(other, 1.0)
      it 'should move in the direction provided', ->
        instance.x.should.equal 1
        instance.y.should.equal 2.0
      it 'should return true', ->
        rv.should.equal true

    describe 'overshoot', ->
      rv = null
      beforeEach ->
        rv = instance.move_towards(other, 2.0)
      it 'should stop at the destination', ->
        instance.x.should.equal 1
        instance.y.should.equal 2.0
      it 'should return true', ->
        rv.should.equal true
