{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Limit.Exercise (
    limitExercise
  ) where

import Control.Monad.Fix (MonadFix)

import Reflex

limitExercise :: (Reflex t, MonadFix m, MonadHold t m)
             => Behavior t Int
             -> Event t ()
             -> Event t ()
             -> m (Behavior t Int)
limitExercise bCount eAdd eReset = mdo
  pure (pure 0)
