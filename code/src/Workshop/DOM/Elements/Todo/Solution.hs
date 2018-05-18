{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Workshop.DOM.Elements.Todo.Solution (
    todoSolution
  ) where

import Data.Bool (bool)

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
todoItem dItem = divClass "d-flex flex-row align-items-center" $ do
  let
    dText = view todoItem_text <$> dItem
    -- dText = (^. todoItem_text) <$> dItem
    -- dText = dItem ^. mapping todoItem_text
  divClass "p-1" $
    dynText dText
  divClass "p-1" $
    button "x"

todoSolution :: MonadWidget t m
             => m ()
todoSolution = do
  eRemove <- el "div" $
    todoItem $ pure (TodoItem "This is just a test")

  dCount <- count eRemove

  el "div" $ do
    text "Remove has been pressed "
    display dCount
    text " time"
    dynText $ bool "s" "" . (== 1) <$> dCount
  pure ()
