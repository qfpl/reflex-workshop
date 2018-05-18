{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Inputs.Checkbox.Solution (
    todoSolution
  ) where

import Data.Bool (bool)
import Data.Monoid ((<>))

import Control.Lens

import Data.Text (Text)

import Reflex.Dom.Core

import Workshop.DOM.Inputs.Checkbox.Common

itemComplete :: MonadWidget t m
             => Dynamic t Bool
             -> m (Event t (Bool -> Bool))
itemComplete dComplete =
  divClass "p-1" $ do
    iComplete <- sample . current $ dComplete
    cb <- checkbox iComplete $
      def & setValue .~ updated dComplete
    pure $ const <$> cb ^. checkbox_change

itemText :: MonadWidget t m
         => Dynamic t Bool
         -> Dynamic t Text
         -> m ()
itemText dComplete dText =
  let
    completeClass = bool "" " completed" <$> dComplete
  in
    elDynClass "div" (pure "p-1" <> completeClass) $
      dynText dText

itemRemove :: MonadWidget t m
           => m (Event t ())
itemRemove =
  divClass "p-1" $
    button "x"

todoItem :: MonadWidget t m
         => Dynamic t TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem dItem = do
  dComplete <- holdUniqDyn $ view todoItem_complete <$> dItem
  dText     <- holdUniqDyn $ view todoItem_text     <$> dItem

  divClass "d-flex flex-row align-items-center" $ do
    {--}
    eComplete <- itemComplete dComplete
    itemText dComplete dText
    eRemove <- itemRemove

    let
      eChange = over todoItem_complete <$> eComplete
    {--}

    {-
    eChange <- divClass "p-1" $ do
      iComplete <- sample . current $ dComplete
      cb <- checkbox iComplete $
        def & setValue .~ updated dComplete
      pure $ set todoItem_complete <$> cb ^. checkbox_change

    let
      completeClass = bool "" " completed" <$> dComplete
    elDynClass "div" (pure "p-1" <> completeClass) $
      dynText dText

    eRemove <- divClass "p-1" $
      button "x"
    -}

    pure (eChange, eRemove)

firings :: MonadWidget t m
        => Text
        -> Event t a
        -> m ()
firings label e = el "div" $ do
  dCount <- count e

  text label
  text " has been fired "
  display dCount
  text " time"
  dynText $ bool "s" "" . (== 1) <$> dCount

todoSolution :: MonadWidget t m
             => m ()
todoSolution = mdo
  dTodo <- foldDyn ($) (TodoItem False "This is just a test") eChange
  (eChange, eRemove) <- el "div" $
    todoItem dTodo

  firings "Change" eChange
  firings "Remove" eRemove
