{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE GADTs #-}
module Todo.Solution.Item.DMap where

import Control.Monad
import Data.Bool
import Data.Monoid

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Data.GADT.Compare
import Data.Dependent.Map (DMap, DSum(..))
import qualified Data.Dependent.Map as DMap

import Reflex.Dom.Core

import Todo.Common

data TodoTag a where
  TodoComplete :: TodoTag Bool
  TodoText :: TodoTag Text
  TodoRemove :: TodoTag ()

instance GEq TodoTag where
  geq TodoComplete TodoComplete = Just Refl
  geq TodoText TodoText = Just Refl
  geq TodoRemove TodoRemove = Just Refl
  geq _ _ = Nothing

instance GCompare TodoTag where
  gcompare TodoComplete TodoComplete = GEQ
  gcompare TodoComplete _ = GLT
  gcompare _ TodoComplete = GGT
  gcompare TodoText TodoText = GEQ
  gcompare TodoText _ = GLT
  gcompare _ TodoText = GGT
  gcompare TodoRemove TodoRemove = GEQ

todoComplete :: MonadWidget t m
             => Bool
             -> m (Event t (DMap TodoTag Identity))
todoComplete iComplete =
  divClass "p-1" $ do
    cb <- checkbox iComplete def
    pure . merge . DMap.singleton TodoComplete $ cb ^. checkbox_change

todoTextRead :: MonadWidget t m
             => Dynamic t Bool
             -> Text
             -> Workflow t m (Event t (DMap TodoTag Identity))
todoTextRead dComplete iText = Workflow $ do
  let
    dCompleteClass = bool "" " completed" <$> dComplete
  (e, _) <- elDynClass' "div" (pure "p-1" <> dCompleteClass) $
    text iText
  pure (never, todoTextWrite dComplete iText <$ domEvent Dblclick e)

todoTextWrite :: MonadWidget t m
              => Dynamic t Bool
              -> Text
              -> Workflow t m (Event t (DMap TodoTag Identity))
todoTextWrite dComplete iText = Workflow $ do
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
      eChange  = eNotNull
      eOut = DMap.fromList [TodoText :=> eChange, TodoRemove :=> eRemove]
    pure (merge eOut, todoTextRead dComplete <$> eNotNull)

todoText :: MonadWidget t m
         => Dynamic t Bool
         -> Text
         -> m (Event t (DMap TodoTag Identity))
todoText dComplete iText = do
  dem <- workflow $ todoTextRead dComplete iText
  pure $ switchDyn dem

todoRemove :: MonadWidget t m
           => m (Event t (DMap TodoTag Identity))
todoRemove = do
  eRemove <- divClass "p-1" $
     button "x"
  pure . merge $ DMap.singleton TodoRemove eRemove

todoItem :: MonadWidget t m
         => TodoItem
         -> m (Event t (TodoItem -> TodoItem), Event t ())
todoItem item =
  divClass "d-flex flex-row align-items-center" $ do
    let
      iComplete = item ^. todoItem_complete
      iText     = item ^. todoItem_text

    edmComplete <- todoComplete iComplete
    let
      esComplete = fan edmComplete
      eComplete = select esComplete TodoComplete

    dComplete <- holdDyn iComplete eComplete
    edmText <- todoText dComplete iText
    edmRemove <- todoRemove

    let
      edmAll = mergeWith DMap.union [
          edmComplete
        , edmText
        , edmRemove
        ]
      esAll = fan edmAll
      eChange = mergeWith (.) [
          set todoItem_complete <$> select esAll TodoComplete
        , set todoItem_text     <$> select esAll TodoText
        ]
      eRemove = select esAll TodoRemove

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
