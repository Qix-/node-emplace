# node-emplace [![Travis-CI.org Build Status](https://img.shields.io/travis/Qix-/node-emplace.svg?style=flat-square)](https://travis-ci.org/Qix-/node-emplace) [![Coveralls.io Coverage Rating](https://img.shields.io/coveralls/Qix-/node-emplace.svg?style=flat-square)](https://coveralls.io/r/Qix-/node-emplace)
> Emplace objects and arrays - pointer to pointer style!

## Example

```javascript
var emplace = require('emplace');

var obj = {foo: 1234};
var obj2 = {bar: 'hello'};

emplace.replace(obj, obj2);

console.log(obj.foo); //-> undefined
console.log(obj.bar); //-> hello
```

# API

#### `.clear(obj)`
Clears an object's properties in-place.

```javascript
var obj = {foo: 1234};

emplace.clear(obj);

console.log('foo' in obj); //-> false
```

#### `.append(obj, otherObj)`
Either appends an array, or merges two objects (overwriting duplicate keys).

```javascript
var obj = {foo: 1234};
var obj2 = {bar: 'hello'};

emplace.append(obj, obj2);

console.log(obj.foo); //-> 1234
console.log(obj.bar); //-> 'hello'
```

#### `.replace(obj, otherObj)`
First `.clear`s the object, then `.append`s to it.

See [example](#example).

## License
Licensed under the [MIT License](http://opensource.org/licenses/MIT).
You can find a copy of it in [LICENSE](LICENSE).
