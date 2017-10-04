module Test.Main where

import Prelude
import Control.Monad.Aff (delay)
import Control.Monad.Eff (Eff)
import Data.Time.Duration (Milliseconds(..))
import Test.Spec (SpecEffects, describe, it, pending)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Mocha (MOCHA, runMocha)

main :: Eff (SpecEffects (mocha :: MOCHA)) Unit
main = runMocha do
  describe "test" $
    describe "nested" do
      it "works" $
        (1 + 1) `shouldEqual` 2
      pending "is pending"

  describe "test" $
    describe "other" do
      it "breaks" $ 1 `shouldEqual` 2

  describe "async" do
    it "works" $ do
      expected <- do
        delay (Milliseconds 1.0)
        pure 2
      (1 + 1) `shouldEqual` expected
    it "and can fail" do
      expected <- do
        delay (Milliseconds 1.0)
        pure 3
      (1 + 1) `shouldEqual` expected
