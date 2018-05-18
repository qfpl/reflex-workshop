{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Collections.Lists.Adding.Exercise (
    addingExercise
  ) where

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Workshop.DOM.Inputs.TextInput.Common

addItem :: MonadWidget t m
        => m (Event t TodoItem)
addItem =
  pure never

addingExercise :: MonadWidget t m
               => [TodoItem]
               -> (Dynamic t TodoItem -> m (Event t (TodoItem -> TodoItem), Event t ()))
               -> m ()
addingExercise tis fSingle =
  pure ()
