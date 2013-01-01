Cell = require '../lib/cell'

describe 'Cell', ->
  it 'should fail to construct without a Location', ->
    expect(-> new Cell).to.throw()
  it 'should construct with a Location', ->
    expect(-> new Cell({})).to.not.throw()
  describe '(unwired)', ->
    instance = null
    beforeEach -> instance = new Cell({})
    it 'should not be valid', ->
      instance.valid.should.not.be.ok
    it 'should wire with four arguments', ->
      expect(-> instance.wire('n', 'e', 'w', 's')).to.not.throw()
    it 'should have a null .piece', ->
      expect(instance.piece).to.equal null
  describe '(wired)', ->
    instance = null
    beforeEach ->
      instance = new Cell({})
      instance.wire('n', 'e', 'w', 's')
    it 'should be valid', ->
      instance.valid.should.be.ok
    it 'should take them in NEWS order', ->
      instance.n.should.equal 'n'
      instance.e.should.equal 'e'
      instance.w.should.equal 'w'
      instance.s.should.equal 's'
  describe '(border)', ->
    instance = null
    beforeEach ->
      instance = new Cell({})
      instance.wire('n', null, null, null)
    it 'should be valid', ->
      instance.valid.should.be.ok
    it 'should return an invalid cell for a null neighbor', ->
      instance.s.valid.should.not.be.ok
    it 'should return an invalid cell after going further off the board', ->
      instance.s.s.valid.should.not.be.ok
    it 'should return an invalid cell after hopping off-and-on the board', ->
      instance.s.n.valid.should.not.be.ok

