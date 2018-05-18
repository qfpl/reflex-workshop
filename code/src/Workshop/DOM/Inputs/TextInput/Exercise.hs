{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Inputs.TextInput.Exercise (
    todoItem
  , todoExercise
  ) where

import Control.Lens

import Data.Text (Text)

import Reflex.Dom.Core

import Workshop.DOM.Inputs.TextInput.Common

todoItem :: MonadWidget t m
         => Dynamic t TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem dItem = do
  pure (never, never)

todoExercise :: MonadWidget t m
             => m ()
todoExercise = do
  pure ()
