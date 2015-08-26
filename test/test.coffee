should = require 'should'
emplace = require '../'

Error.stackTraceLimit = Infinity

it 'should clear an object', ->
  obj = foo: 1234, bar: 4321, qix: 1337
  emplace.clear obj
  obj.should.not.have.property 'foo'
  obj.should.not.have.property 'bar'
  obj.should.not.have.property 'qix'
  Object.getOwnPropertyNames(obj).length.should.equal 0

it 'should append objects in-place', ->
  obj = foo: 1234
  obj_ = bar: 4321

  arr = [1, 2, 3, 4, 5]
  arr_ = [9, 8, 7, 6, 5]

  emplace.append obj, obj_
  emplace.append arr, arr_

  obj.should.have.property 'foo'
  obj.should.have.property 'bar'
  obj.foo.should.equal 1234
  obj.bar.should.equal 4321

  arr.length.should.equal 10
  arr.should.deepEqual [1, 2, 3, 4, 5, 9, 8, 7, 6, 5]

it 'should replace objects in-place', ->
  obj = foo: 1234
  obj_ = bar: 4321

  arr = [1, 2, 3, 4, 5]
  arr_ = [9, 8, 7, 6, 5]

  emplace.replace obj, obj_
  emplace.replace arr, arr_

  obj.should.not.have.property 'foo'
  obj.should.have.property 'bar'
  obj.bar.should.equal 4321

  arr.length.should.equal 5
  arr.should.deepEqual [9, 8, 7, 6, 5]

it 'should replace an object with an array', ->
  obj = foo: 1234
  arr = [1, 2, 3, 4, 5]

  emplace.replace obj, arr

  obj.length.should.equal 5
  obj[0].should.equal 1
  obj[4].should.equal 5
  obj.slice().should.deepEqual [1, 2, 3, 4, 5]

it 'should throw upon clearing un-configurable', ->
  obj = {}
  Object.defineProperty obj, 'foo', value: 1234
  (->
    emplace.clear obj
  ).should.throw 'Cannot delete property \'foo\' of #<Object>'

it 'should delete non-enumerable property', ->
  obj = {}
  Object.defineProperty obj, 'foo', {value: 1234, configurable: true}
  emplace.clear obj
  (should obj.foo).not.be.ok()
  obj.should.not.have.property 'foo'
