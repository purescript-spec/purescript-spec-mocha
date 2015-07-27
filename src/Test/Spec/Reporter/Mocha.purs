module Test.Spec.Reporter.Mocha (
  mochaReporter,
  MOCHA()
  ) where

import Prelude

import Control.Monad.Eff           (Eff())
import Control.Monad.Eff.Exception (Error())
import Data.Foldable               (traverse_)
import Test.Spec                   (Result(..), Group(..))
import Test.Spec.Reporter          (Reporter())

foreign import data MOCHA :: !

foreign import itSuccess :: forall e. String
                         -> Eff (mocha :: MOCHA | e) Unit

foreign import itFailure :: forall e. String
                         -> Error
                         -> Eff (mocha :: MOCHA | e) Unit

foreign import itPending :: forall e. String
                         -> Eff (mocha :: MOCHA | e) Unit

foreign import describe :: forall e. String
                        -> Eff (mocha :: MOCHA | e) Unit
                        -> Eff (mocha :: MOCHA | e) Unit

registerGroup :: forall e. Group
              -> Eff (mocha :: MOCHA | e) Unit
registerGroup (It name Success) = itSuccess name
registerGroup (It name (Failure err)) = itFailure name err
registerGroup (Pending name) = itPending name
registerGroup (Describe name groups) =
  describe name (traverse_ registerGroup groups)

mochaReporter :: forall e. Reporter (mocha :: MOCHA | e)
mochaReporter groups = traverse_ registerGroup groups
