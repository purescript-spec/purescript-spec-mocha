module Test.Spec.Mocha (runMocha) where

import Prelude

import Data.Either (Either(..), either)
import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff, Error, runAff_)
import Test.Spec (SpecT, collect)
import Test.Spec.Tree (Item(..), Tree(..))

foreign import mochaItAsync
  :: Boolean
  -> String
   -> (Effect Unit
       -> (Error -> Effect Unit)
       -> Effect Unit)
   -> Effect Unit

foreign import mochaPending
   :: String
   -> Effect Unit

foreign import mochaDescribe
  :: Boolean
  -> String
  -> Effect Unit
  -> Effect Unit

registerGroup
  :: ∀ m
   . Tree String m (Item Aff Unit)
  -> Effect Unit
registerGroup tree =
  case tree of
    Leaf name (Just (Item { isFocused, example })) ->
        mochaItAsync isFocused name cb
        where
          cb onSuccess onError =
            runAff_ (either onError (const onSuccess)) (example (\a -> a unit))
    Leaf name Nothing ->
      mochaPending name
    Node (Left a) t ->
      mochaDescribe false a $
        traverse_ registerGroup t
    Node _ t ->
      traverse_ registerGroup t

runMocha
  :: ∀ a
   . SpecT Aff Unit Effect a
  -> Effect Unit
runMocha spec =
   traverse_ registerGroup =<< collect spec
