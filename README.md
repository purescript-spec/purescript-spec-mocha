# purescript-spec-mocha

purescript-spec-mocha is a runner and reporter for
[purescript-spec](https://github.com/owickstrom/purescript-spec) that run tests
and reports the results using the Mocha interface (`describe`, `it` etc). This
enables you to use purescript-spec together with `mocha` and `karma`, and thus
run tests in web browsers, as well as NodeJS.

## Usage

```bash
bower install purescript-spec-mocha
```

```purescript
module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Test.Spec (SpecEffects, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Mocha (MOCHA, runMocha)

main :: Eff (SpecEffects (mocha :: MOCHA)) Unit
main = runMocha do
  describe "your feature" do
    it "works" $
      (1 + 1) `shouldEqual` 2
```

### Usage with bundled Purescript
If you bundle your compiled PureScript it can be run with `mocha bundle.js` or
using Karma and [karma-mocha](https://github.com/karma-runner/karma-mocha).

```bash
pulp browserify -I test --main Test.Main > bundle.js
mocha bundle.js
```

### Usage in the browser
If you want to mix in Purescript tests with existing Javascript (or
Coffeescript) Mocha tests running in the browser, you'll need to import the file
and call the function exported by your Purescript test. E.g. combining the
example from [Running Mocha in the
Browser](https://mochajs.org/#running-mocha-in-the-browser) with the above
Purscript spec, you'll need:

```html
<!-- test/index.html -->
...
  <script>mocha.setup('bdd')</script>
  <script src="all_tests.js"></script>
  <script>
    mocha.checkLeaks();
    mocha.globals(['jQuery']);
    mocha.run();
  </script>
...
```

```javascript
// all_tests.js
require('test.array.js');               // Javascript specs load when the the file is parsed.
require('test.object.js');
require('test.xhr.js');

{main} = require('my_purescript_spec');
main();                                 // Purescript specs load when the function is called.
```

### Usage with Spago and Parcel

With `spago` and `parcel-bundler`, and the above `test/index.html` you can build tests, and run them on node and browsers with the following entries in your `package.json`
```json
...
  "scripts": {
    "test:build": "spago bundle-app --main Test.Main --to ./output/test.js",
    "test:watch": "spago bundle-app --watch --main Test.Main --to ./output/test.js --then \"npm run -s test:node\"",
    "test:node": "mocha ./output/test.js",
    "test:browser": "parcel test/index.html --open"
  },
...
```

Running `npm run test:watch` in one terminal window and `npm run test:browser` in another will watch purescript source and tests files and automatically run node and browser tests.

## API Documentation

See [docs on Pursuit](https://pursuit.purescript.org/packages/purescript-spec-mocha).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-mocha/issues).
Pull requests requests are encouraged.

### Running Tests

This project's tests include some failures to test the Mocha
integration. Thus, use `run_tests.sh` instead of `pulp test` to check
that everything is all right.

## License

[MIT License](LICENSE.md).
