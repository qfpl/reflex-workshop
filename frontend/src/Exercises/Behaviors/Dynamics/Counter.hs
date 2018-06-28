{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Exercises.Behaviors.Dynamics.Counter (
    counterExercise
  ) where

import Control.Monad.Fix (MonadFix)

import Control.Lens

import Reflex

counterExercise :: (Reflex t, MonadFix m, MonadHold t m)
                => Event t (Int -> Int)
                -> m (Dynamic t Int)
counterExercise eFn =
  pure (pure 0)
