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
module Todo.Solution.Item.Part10 where

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

todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t (EventWriterT t () m) (Event t (Text -> Text))
todoTextRead dComplete iText = Workflow $ do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
  (e, _) <- elDynClass' "div" (pure "p-1" <> dCompleteClass) $
    text iText
  pure (never, todoTextWrite dComplete iText <$ domEvent Dblclick e)

todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> Workflow t (EventWriterT t () m) (Event t (Text -> Text))
todoTextWrite dComplete iText = Workflow $
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
      eChange  = const <$> eNotNull

    tellEvent eRemove

    pure (eChange, todoTextRead dComplete <$> eNotNull)

todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> EventWriterT t () m (Event t (Text -> Text))
todoText dComplete iText = do
  de <- workflow $ todoTextRead dComplete iText
  pure $ switchDyn de

todoRemove :: MonadWidget t m
           => EventWriterT t () m ()
todoRemove =
  divClass "p-1" $ do
     eRemove <- button "x"
     tellEvent eRemove

todoItem :: MonadWidget t m
         => TodoItem
         -> EventWriterT t () m (Event t (TodoItem -> TodoItem))
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    eComplete <- todoComplete iComplete
    dComplete <- foldDyn ($) iComplete eComplete
    eText <- todoText dComplete iText
    todoRemove

    pure $
      mergeWith (.) [
          over todoItem_complete <$> eComplete
        , over todoItem_text <$> eText
        ]


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
  (eChange, eRemove) <- runEventWriterT $ el "div" $
    todoItem item

  firings "Change" eChange
  firings "Remove" eRemove
