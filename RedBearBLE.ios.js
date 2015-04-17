/**
 * @providesModule RedBearBLE
 * @flow
 */
'use strict';

var NativeRedBearBLE = require('NativeModules').RedBearBLE;
var invariant = require('invariant');

/**
 * High-level docs for the RedBearBLE iOS API can be written here.
 */

var RedBearBLE = {
  test: function() {
    NativeRedBearBLE.test();
  }
};

module.exports = RedBearBLE;
