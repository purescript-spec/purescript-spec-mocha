module Test.Main where

import Prelude
import Control.Monad.Aff (delay)
import Control.Monad.Eff (Eff)
import Test.Spec (SpecEffects, describe, it, pending)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Mocha (MOCHA, runMocha)
import Data.Time.Duration(Milliseconds(..))

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
      delay $ Milliseconds 1000.0
      expected <- pure 2
      (1 + 1) `shouldEqual` expected
    it "and can fail" do
      delay $ Milliseconds 1000.0
      expected <- pure 3
      (1 + 1) `shouldEqual` expected
