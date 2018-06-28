{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Exercises.Behaviors.Creating.Fmap (
    fmapExercise
  ) where

import Reflex

fmapExercise :: (Reflex t, MonadHold t m)
             => Event t Int
             -> m (Behavior t Int)
fmapExercise eIn =
  pure (pure 0)
