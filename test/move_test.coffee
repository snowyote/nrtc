Move = require '../lib/move'

describe 'Move', ->
  it 'should require both ends', ->
    expect(-> new Move).to.throw()
    expect(-> new Move({}, {})).to.not.throw()
  it 'should be valid iff both ends are valid', ->
    i = { valid: false }
    v = { valid: true  }
    new Move(v, v).valid.should.equal true
    new Move(i, v).valid.should.equal false
    new Move(v, i).valid.should.equal false
    new Move(i, i).valid.should.equal false
    