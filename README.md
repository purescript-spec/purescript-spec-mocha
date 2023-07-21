# purescript-spec-mocha

purescript-spec-mocha is a runner and reporter for
[purescript-spec](https://github.com/purescript-spec/purescript-spec) that run tests
and reports the results using the Mocha interface (`describe`, `it` etc). This
enables you to use purescript-spec together with `mocha` and `karma`, and thus
run tests in web browsers, as well as NodeJS.

## Usage

```bash
spago install spec-mocha
```

```purescript
module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Test.Spec (SpecEffects, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Mocha (runMocha)

main :: Effect Unit
main = runMocha do
  describe "your feature" do
    it "works" $
      (1 + 1) `shouldEqual` 2
```

See `test/Main.purs` for a more detailed example. The `package.json` scripts in this repo, show a number of usage patterns further detailed below. Note that the example tests contain 2 passing tests, a pending test and 2 failing tests, to demonstrate both success and failure.

### Usage with bundled Purescript

You can run `yarn test:node` or `npm run test:node` in this repo to see an example.

If you bundle your compiled PureScript it can be run with `mocha bundle.js` or
using Karma and [karma-mocha](https://github.com/karma-runner/karma-mocha).

```bash
spago bundle-app --main Test.Main --to bundle.js
mocha bundle.js
```

### Usage in the browser

To run mocha tests in the browser, you can run `yarn test:browser` or `npm run test:browser` in this repo to see an example using the `test/index.html` file.

```html
<script>mocha.setup("bdd");</script>
<script src="../output/test.js"></script>
<script>mocha.run();</script>
```

It's also possible to bundle the test as a module in which case you'll need to use `type="module"`:

```html
<script type="module" src="./index_module.js"></script>
```

and to import the test module as shown in the `test/index_module.js` file:

```javascript
import { main } from "../output/test_module.js";

mocha.setup("bdd");
main();
mocha.run();
```

Running `npm run test:watch` in one terminal window and `npm run test:browser` in another will watch purescript source and tests files and automatically run node and browser tests.

### Usage with headless browser 

You can run `yarn test:headless` or `npm run test:headless` in this repo to see an example using the `test/index.html` file together with `mocha-headless-chrome`. Note that we need to disable-web-security in chromium to allow cross-origin requests.

## API Documentation

See [docs on Pursuit](https://pursuit.purescript.org/packages/purescript-spec-mocha).

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/purescript-spec/purescript-spec-mocha/issues).
Pull requests requests are encouraged.

### Running Tests

This project's tests include some failures to test the Mocha
integration. Thus, use `run_tests.sh` instead of `spago test` to check
that everything is all right.

## License

[MIT License](LICENSE.md).
