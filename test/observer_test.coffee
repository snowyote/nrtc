{observe, unobserve} = require '../lib/observer'

describe 'Observer', ->
  subject = orig_args = null
  beforeEach ->
    orig_args = []
    subject = { foo: (blargs...) -> orig_args.push blargs }

  it 'should import', ->
    observe.should.be.a 'function'
    unobserve.should.be.a 'function'

  it 'should observe', ->
    wrapper_args = []
    observe subject, 'foo', (blargs...) -> wrapper_args.push blargs
    subject.foo(1,2,3)
    orig_args.should.deep.equal [[1,2,3]]
    wrapper_args.should.deep.equal [[1,2,3]]

  it 'should call wrapper first', ->
    observe subject, 'foo', (blargs...) -> orig_args = []
    orig_args = ['barf']
    subject.foo()
    orig_args.should.not.contain 'barf'
    orig_args.should.deep.equal [[]]

  it 'should preserve this', ->
    observe subject, 'foo', (blargs...) -> throw new Error "Wrong" if this isnt subject
    expect(-> subject.foo()).to.not.throw()

  it 'should be removable', ->
    observer = (blargs...) -> throw new Error "Happy New Year!"
    observe subject, 'foo', observer
    expect(-> subject.foo()).to.throw()
    unobserve(subject, 'foo')
    expect(-> subject.foo()).to.not.throw()

  it 'should be chainable', ->
    first = second = null
    first_observer = -> first = 'ding'
    second_observer = -> second = 'dong'
    observe subject, 'foo', first_observer
    observe subject, 'foo', second_observer
    subject.foo()
    expect(first).to.equal 'ding'
    expect(second).to.equal 'dong'

  it 'allows removing an earlier-added observer', ->
    first = second = null
    first_observer = -> first = 'ding'
    second_observer = -> second = 'dong'
    observe subject, 'foo', first_observer
    observe subject, 'foo', second_observer
    unobserve subject, 'foo', first_observer
    subject.foo()
    expect(first).to.equal null
    expect(second).to.equal 'dong'

  it 'allows removing a later-added observer', ->
    first = second = null
    first_observer = -> first = 'ding'
    second_observer = -> second = 'dong'
    observe subject, 'foo', first_observer
    observe subject, 'foo', second_observer
    unobserve subject, 'foo', second_observer
    subject.foo()
    expect(first).to.equal 'ding'
    expect(second).to.equal null

  