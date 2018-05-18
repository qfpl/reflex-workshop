{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Workshop.DOM.Elements.Todo.Exercise (
    todoExercise
  ) where

import Control.Lens

import Data.Text (Text)

import Reflex.Dom.Core

data TodoItem =
  TodoItem {
    _todoItem_text :: Text
  }

makeLenses ''TodoItem

todoItem :: MonadWidget t m
         => Dynamic t TodoItem
         -> m (Event t ())
todoItem dItem = do
  pure never

todoExercise :: MonadWidget t m
             => m ()
todoExercise = do
  pure ()
