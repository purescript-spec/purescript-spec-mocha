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

If you bundle your compiled PureScript it can be run with `mocha bundle.js` or
using Karma and [karma-mocha](https://github.com/karma-runner/karma-mocha).

```bash
pulp browserify -I test --main Test.Main > bundle.js
mocha bundle.js
```

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
