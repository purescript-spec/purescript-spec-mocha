module Test.Spec.Mocha (
  runMocha,
  MOCHA()
  ) where

import Prelude
import Control.Monad.Aff (Aff, Error, runAff_)
import Control.Monad.Eff (Eff, kind Effect)
import Data.Either (either)
import Data.Foldable (traverse_)
import Test.Spec (Spec, Group(..), collect)

foreign import data MOCHA :: Effect

foreign import itAsync
  :: forall e
   . Boolean
  -> String
   -> (Eff e Unit
       -> (Error -> Eff e Unit)
       -> Eff e Unit)
   -> Eff (mocha :: MOCHA | e) Unit

foreign import itPending
  :: forall e
   . String
   -> Eff (mocha :: MOCHA | e) Unit

foreign import describe
  :: forall e
   . Boolean
  -> String
  -> Eff (mocha :: MOCHA | e) Unit
  -> Eff (mocha :: MOCHA | e) Unit

registerGroup
  :: forall e
   . (Group (Aff e Unit))
  -> Eff (mocha :: MOCHA | e) Unit
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
   . Spec e Unit
  -> Eff (mocha :: MOCHA | e) Unit
runMocha spec = traverse_ registerGroup (collect spec)
