/* global exports, it */

// module Test.Spec.Reporter.Mocha

if (!describe || !it) {
  throw new Error('Mocha globals seem to be unavailable!');
}

exports.itAsync = function (name) {
  "use strict";
    return function (aff) {
        return function () {
            it(name, function (done) {
                aff(function () {
                    done();
                }, function (err) {
                    done(err);
                })
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
