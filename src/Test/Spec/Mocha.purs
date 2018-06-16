module Test.Spec.Mocha (
  runMocha,
  MOCHA()
  ) where

import Prelude
import Effect.Aff (Aff, Error, runAff_)
import Effect (Effect)
import Data.Either (either)
import Data.Foldable (traverse_)
import Test.Spec (Spec, Group(..), collect)

foreign import data MOCHA :: Type

foreign import itAsync
  :: Boolean
  -> String
   -> (Effect Unit
       -> (Error -> Effect Unit)
       -> Effect Unit)
   -> Effect Unit

foreign import itPending
   :: String
   -> Effect Unit

foreign import describe
  :: Boolean
  -> String
  -> Effect Unit
  -> Effect Unit

registerGroup
  :: Group (Aff Unit)
  -> Effect Unit
registerGroup (It only name test) =
  itAsync only name cb
  where
    cb onSuccess onError =
      runAff_ (either onError (const onSuccess)) test
registerGroup (Pending name) = itPending name
registerGroup (Describe only name groups) =
  describe only name (traverse_ registerGroup groups)

runMocha
  :: forall e
   . Spec Unit
  -> Effect Unit
runMocha spec = traverse_ registerGroup (collect spec)
