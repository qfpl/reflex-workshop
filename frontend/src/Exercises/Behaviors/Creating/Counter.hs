{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Exercises.Behaviors.Creating.Counter (
    counterExercise
  ) where

import Control.Monad.Fix (MonadFix)
import Data.Function

import Reflex

counterExercise :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Behavior t Int, Event t Int)
counterExercise eFn =
  pure (pure 0, never)
