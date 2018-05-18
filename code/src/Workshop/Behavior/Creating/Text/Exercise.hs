{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Text.Exercise (
    textExercise
  ) where

import Control.Monad.Fix (MonadFix)

import Data.Text (Text)

import Reflex

textExercise :: (Reflex t, MonadFix m, MonadHold t m)
             => Behavior t Int
             -> Event t Text
             -> m (Behavior t [Text], Event t [Text])
textExercise bIn eIn = mdo
  pure (pure [], never)
