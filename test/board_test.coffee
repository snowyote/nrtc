Board = require '../lib/board'
  
describe 'Board', ->
  it 'should let me to do these things', ->
    "something".should.equal "something"
    "something".should.not.equal "something else"
    Board.should.not.equal undefined
    (new Board).should.not.equal undefined
  it 'should exist via expect', ->
    expect(new Board).to.not.equal null
  it 'should exist via should', ->
    (new Board).should.not.equal null
