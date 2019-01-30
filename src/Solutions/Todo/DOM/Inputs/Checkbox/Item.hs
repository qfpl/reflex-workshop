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
module Solutions.Todo.DOM.Inputs.Checkbox.Item where

import Data.Bool

import Control.Lens

import Data.Text (Text)

import Reflex.Dom.Core

import Common.Todo

todoComplete :: MonadWidget t m
             => Bool
             -> m (Event t (Bool -> Bool))
todoComplete iComplete =
  divClass "p-1" $ do
    cb <- checkbox iComplete def
    pure $ const <$> cb ^. checkbox_change

todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m ()
todoText dComplete iText = do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
  elDynClass "div" (pure "p-1" <> dCompleteClass) $
    text iText

todoRemove :: MonadWidget t m
           => m (Event t ())
todoRemove =
  divClass "p-1" $
     button "x"

todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
    todoText dComplete iText
    eRemove <- todoRemove

    let
      eChange = over todoItem_complete <$> eComplete

    pure (eChange, eRemove)

firings :: forall t m a. 
           MonadWidget t m
        => Text
        -> Event t a
        -> m ()
firings label e =
  el "div" $ do
    dCount :: Dynamic t Int <- count e

    text label
    text " has been fired "
    display dCount
    text " time"
    dynText $ bool "s" "" . (== 1) <$> dCount

todoItemSolution :: MonadWidget t m
                 => TodoItem
                 -> m ()
todoItemSolution item = do
  (eChange, eRemove) <- el "div" $
    todoItem item

  firings "Change" eChange
  firings "Remove" eRemove
