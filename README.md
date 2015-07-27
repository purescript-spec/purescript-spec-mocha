# purescript-spec-reporter-mocha

purescript-spec-reporter-mocha is a reporter for
[purescript-spec](https://github.com/owickstrom/purescript-spec) that reports
the test results using the Mocha interface (`describe`, `it` etc). This enables
you to use purescript-spec together with `mocha` and `karma`.

## Usage

```bash
bower install purescript-spec-reporter-mocha
```

```purescript
module Main where

import Prelude

import Test.Spec
import Test.Spec.Runner
import Test.Spec.Reporter.Mocha

main = run [mochaReporter] do
  ...
```

If you bundle your compiled PureScript it can be run with `mocha bundle.js` or
using Karma and [karma-mocha](https://github.com/karma-runner/karma-mocha).

```bash
pulp browserify -I test --main Test.Main > bundle.js
mocha bundle.js
```

## API Documentation

See [the docs directory](docs/).

### Generating Docs

```bash
pulp docs
```

## Contribute

If you have any issues or possible improvements please file them as
[GitHub Issues](https://github.com/owickstrom/purescript-spec-reporter-mocha/issues).
Pull requests requests are encouraged.

## License

[MIT License](LICENSE.md).
