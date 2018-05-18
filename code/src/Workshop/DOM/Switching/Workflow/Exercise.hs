{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Switching.Workflow.Exercise (
    workflowExercise
  ) where

import Reflex.Dom.Core

workflowExercise :: MonadWidget t m
                 => Event t ()
                 -> m (Dynamic t Int)
workflowExercise eChange = do
  pure (pure 0)
