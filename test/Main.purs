module Test.Main where

import Prelude

import Control.Monad.Aff (later')

import Test.Spec (describe, it, pending)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Mocha (runMocha)

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
      expected <- later' 1000 (pure 2)
      (1 + 1) `shouldEqual` expected
    it "and can fail" do
      expected <- later' 1000 (pure 3)
      (1 + 1) `shouldEqual` expected
