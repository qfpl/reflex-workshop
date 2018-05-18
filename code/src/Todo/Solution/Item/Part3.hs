{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Todo.Solution.Item.Part3 where

import Control.Monad
import Data.Bool
import Data.Monoid

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Todo.Common

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
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter  = keypress Enter ti
      bText   = current $ value ti
      eText   = Text.strip <$> bText <@ eEnter
      eChange = const <$> ffilter (not . Text.null) eText
      eRemove = ()    <$  ffilter        Text.null  eText
    pure (eChange, eRemove)

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
    (eText, eRemoveText) <- todoText dComplete iText
    eRemoveButton <- todoRemove

    let
      eChange = mergeWith (.) [
          over todoItem_complete <$> eComplete
        , over todoItem_text     <$> eText
        ]
      eRemove = leftmost [
          eRemoveText
        , eRemoveButton
        ]

    pure (eChange, eRemove)

firings :: MonadWidget t m
        => Text
        -> Event t a
        -> m ()
firings label e =
  el "div" $ do
    dCount <- count e

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
