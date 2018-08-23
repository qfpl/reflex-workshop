{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Behaviors.Creating.Apply (
    applyExercise
  ) where

import Reflex

applyExercise :: (Reflex t, MonadHold t m)
              => Event t Int
              -> m (Behavior t Int, Behavior t Int)
applyExercise eIn =
  pure (pure 0, pure 0)
