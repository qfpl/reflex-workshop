{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Behavior.Dynamics.Unique.Exercise (
    uniqueExercise
  ) where

import Control.Monad.Fix (MonadFix)

import Reflex

uniqueExercise :: (Reflex t, MonadFix m, MonadHold t m)
               => Dynamic t (Int, Int)
               -> m (Dynamic t Int, Dynamic t Int)
uniqueExercise dIn =
  pure (fst <$> dIn, snd <$> dIn)
