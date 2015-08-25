'use strict';

var setPrototypeOf = require('setprototypeof');
var isArrayish = require('is-arrayish');
var emplace = module.exports = {};

function clearArray(array) {
	// http://jsperf.com/splice-length-vs-infinity
	array.splice(0, array.length);
	return array;
}

function clearObject(object) {
	for (var k in object) {
		if (object.hasOwnProperty(k)) {
			// http://jsperf.com/try-delete-catch-vs-getownpropertydescriptor-check
			try {
				delete object[k];
			} catch (e) {}
		}
	}

	return object;
}

emplace.clear = function clear(object) {
	var clearFn = isArrayish(object) ? clearArray : clearObject;
	return clearFn(object);
};

function appendArray(original, newArray) {
	[].splice.apply(original, [original.length, 0].concat(newArray));
	return original;
}

function appendObject(original, newObject) {
	for (var k in newObject) {
		if (newObject.hasOwnProperty(k)) {
			original[k] = newObject[k];
		}
	}

	return original;
}

emplace.append = function append(original, newObject) {
	var appendFn = isArrayish(original) ? appendArray : appendObject;
	return appendFn(original, newObject);
};

emplace.replace = function replace(original, newObject) {
	var originalArray = isArrayish(original);
	var newArray = isArrayish(newObject);

	emplace.clear(original);

	if (newArray && newArray !== originalArray) {
		setPrototypeOf(original, []);
	}

	return emplace.append(original, newObject);
};
