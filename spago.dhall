{ name = "spec-mocha"
, license = "MIT"
, repository = "https://github.com/purescript-spec/purescript-spec-mocha"
, dependencies =
  [ "aff"
  , "datetime"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "maybe"
  , "prelude"
  , "spec"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
