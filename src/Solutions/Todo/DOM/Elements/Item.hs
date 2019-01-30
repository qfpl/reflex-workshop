{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Solutions.Todo.DOM.Elements.Item where

import Data.Bool

import Control.Lens

import Reflex.Dom.Core

import Common.Todo

todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iText     = item ^. todoItem_text
    divClass "p-1" $
      text iText
    divClass "p-1" $
      button "x"

todoItemSolution :: forall t m.
                    MonadWidget t m
                 => TodoItem
                 -> m ()
todoItemSolution item = do
  eRemove <- el "div" $
    todoItem item

  dCount :: Dynamic t Int <- count eRemove

  el "div" $ do
    text "Remove has been pressed "
    display dCount
    text " time"
    dynText $ bool "s" "" . (== 1) <$> dCount
