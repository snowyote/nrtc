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
