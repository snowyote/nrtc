Cooldown = require '../lib/cooldown'

describe 'Cooldown', ->
  subject = null
  beforeEach -> subject = new Cooldown(3)

  it 'should count down', ->
    subject.tick()
    subject.ticks_remaining.should.equal 2

  it 'should return falsy if it isn\'t elapsed', ->
    subject.tick().should.not.be.ok

  it 'should return truthy when elapsed', ->
    subject.tick().should.not.be.ok
    subject.tick().should.not.be.ok
    subject.tick().should.be.ok
    subject.tick().should.be.ok

  describe '#fraction_remaining', ->
    it 'should work', ->
      subject.fraction_remaining().should.equal 1
      subject.tick()
      subject.fraction_remaining().should.equal 2/3
      subject.tick()
      subject.fraction_remaining().should.equal 1/3
      subject.tick()
      subject.fraction_remaining().should.equal 0
      subject.tick()
      subject.fraction_remaining().should.equal 0
