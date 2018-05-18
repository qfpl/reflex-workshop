{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Inputs.TextInput.Solution (
    todoItem
  , todoSolution
  ) where

import Data.Bool (bool)
import Data.Monoid ((<>))

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex.Dom.Core

import Workshop.DOM.Inputs.TextInput.Common

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
         -> m (Event t (Text -> Text), Event t ())
itemText dComplete dText =
  let
    completeClass = bool "" " completed" <$> dComplete
  in
    elDynClass "div" (pure "p-1" <> completeClass) $ do
      iText <- sample . current $ dText
      ti <- textInput $
        def & textInputConfig_initialValue .~ iText
            & setValue .~ updated dText
            & attributes .~ (("class" =:) <$> completeClass)
      let
        eEnter   = keypress Enter ti
        bText   = current $ value ti
        eText   = Text.strip <$> bText <@ eEnter
        eChange = const <$> ffilter (not . Text.null) eText
        eRemove = ()    <$  ffilter        Text.null  eText
      pure (eChange, eRemove)

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

  elDynClass "div" "d-flex flex-row align-items-center " $ do
    eComplete <- itemComplete dComplete
    (eText, eRemoveText) <- itemText dComplete dText
    eRemoveButton <- itemRemove

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
