# purescript-spec-mocha

purescript-spec-mocha is a runner and reporter for
[purescript-spec](https://github.com/owickstrom/purescript-spec) that run tests
and reports the results using the Mocha interface (`describe`, `it` etc). This
enables you to use purescript-spec together with `mocha` and `karma`.

## Usage

```bash
bower install purescript-spec-mocha
```

```purescript
module Main where

import Prelude

import Test.Spec                (describe, it, pending)
import Test.Spec.Assertions     (shouldEqual)
import Test.Spec.Mocha          (runMocha)

main = runMocha do
  ...
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

## License

[MIT License](LICENSE.md).
