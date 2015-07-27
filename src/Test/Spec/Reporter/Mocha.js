/* global exports, it */

// module Test.Spec.Reporter.Mocha

if (!describe || !it) {
  throw new Error('Mocha globals seem to be unavailable!');
}

exports.itSuccess = function (name) {
  "use strict";
  return function () {
    it(name, function () {});
  };
};

exports.itFailure = function (name) {
  "use strict";
  return function (err) {
    return function () {
      it(name, function () {
        throw err;
      });
    };
  };
};

exports.itPending = function (name) {
  "use strict";
  return function () {
    it(name);
  };
};

exports.describe = function (name) {
  "use strict";
  return function (nested) {
    return function () {
      describe(name, function () {
        nested();
      });
    };
  };
};
