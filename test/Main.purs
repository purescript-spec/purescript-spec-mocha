module Test.Main where

import Prelude

import Control.Monad.Eff.Console

import Test.Spec                (describe, it, pending)
import Test.Spec.Runner         (run)
import Test.Spec.Assertions     (shouldEqual)
import Test.Spec.Reporter.Mocha (mochaReporter)

main = run [mochaReporter] do
  describe "test" $
    describe "nested" do
      it "works" $
        (1 + 1) `shouldEqual` 2
      pending "is pending"

  describe "test" $
    describe "other" do
      it "breaks" $ 1 `shouldEqual` 2
