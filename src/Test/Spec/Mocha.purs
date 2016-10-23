module Test.Spec.Mocha (
  runMocha,
  MOCHA()
  ) where

import Prelude

import Control.Monad.Aff           (Aff())
import Control.Monad.Eff           (Eff())

import Data.Foldable               (traverse_)

import Test.Spec                   (Spec, Group(..), collect)

foreign import data MOCHA :: !

foreign import itAsync :: forall e. String
                          -> Aff e Unit
                          -> Eff (mocha :: MOCHA | e) Unit

foreign import itPending :: forall e. String
                         -> Eff (mocha :: MOCHA | e) Unit

foreign import describe :: forall e. String
                        -> Eff (mocha :: MOCHA | e) Unit
                        -> Eff (mocha :: MOCHA | e) Unit

registerGroup :: forall e. (Group (Aff e Unit))
              -> Eff (mocha :: MOCHA | e) Unit
registerGroup (It name test) = itAsync name test
registerGroup (Pending name) = itPending name
registerGroup (Describe name groups) =
  describe name (traverse_ registerGroup groups)

runMocha :: forall e. Spec e Unit
            -> Eff (mocha :: MOCHA | e) Unit
runMocha spec = traverse_ registerGroup (collect spec)
