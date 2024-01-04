/* global exports, it, describe */

// module Test.Spec.Mocha

const checkGlobals = () => {
  if (typeof describe !== "function" || typeof it !== "function") {
    throw new Error("Mocha globals seem to be unavailable!");
  }
};

export const mochaItAsync = function (only) {
  "use strict";
  checkGlobals();
  return function (name) {
    return function (run) {
      return function () {
        var f = only ? it.only : it;
        f(name, function (done) {
          return run(function () {
            done();
            return function () {};
          })(function (err) {
            done(err);
            return function () {};
          })();
        });
      };
    };
  };
};

export const mochaPending = function (name) {
  "use strict";
  checkGlobals();
  return function () {
    it(name);
  };
};

export const mochaDescribe = function (only) {
  "use strict";
  checkGlobals();
  return function (name) {
    return function (nested) {
      return function () {
        var f = only ? describe.only : describe;
        f(name, function () {
          nested();
        });
      };
    };
  };
};
