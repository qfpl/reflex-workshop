{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE TypeFamilies #-}
module Todo.Solution.Item.Part4 where

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

data ItemTextMode =
    ItemTextRead
  | ItemTextWrite
  deriving (Eq, Ord, Show)

todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> m (Event t (Text -> Text), Event t (), Event t ItemTextMode)
todoTextRead dComplete iText = do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
  (e, _) <- elDynClass' "div" (pure "p-1" <> dCompleteClass) $
    text iText
  pure (never, never, ItemTextWrite <$ domEvent Dblclick e)

todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> m (Event t (Text -> Text), Event t (), Event t ItemTextMode)
todoTextWrite dComplete iText = do
  divClass "p-1" $ do
    let
      dCompleteClass =
        bool mempty ("class" =: "completed") <$> dComplete
    ti <- textInput $
      def & textInputConfig_initialValue .~ iText
          & attributes .~ dCompleteClass
    let
      eEnter   = keypress Enter ti
      bText    = current $ value ti
      eText    = Text.strip <$> bText <@ eEnter
      eNotNull =       ffilter (not . Text.null) eText
      eRemove  = () <$ ffilter        Text.null  eText
      eDone    = ItemTextRead <$  eNotNull
      eChange  = const        <$> eNotNull
    pure (eChange, eRemove, eDone)

todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (Text -> Text), Event t ())
todoText dComplete iText = mdo
  des <- widgetHold (todoTextRead dComplete iText) $
           fn <$> eSwitch
  let
    eChange = switchDyn . fmap (view _1) $ des
    eRemove = switchDyn . fmap (view _2) $ des
    eSwitch = switchDyn . fmap (view _3) $ des

    fn ItemTextRead =
      todoTextRead dComplete iText
    fn ItemTextWrite =
      todoTextWrite dComplete iText

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
        , over todoItem_text <$> eText
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
