{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
module UI.Exercise (
    exerciseRule
  ) where

import Control.Monad (void, join, when, forM_)
import Data.Bool (bool)
import Data.Foldable (traverse_)
import Data.Maybe (fromMaybe)
import Data.Semigroup ((<>))
import GHC.Generics

import Control.Monad.Trans (liftIO, lift)
import Control.Monad.Reader (MonadReader, ask)

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Aeson (ToJSON, FromJSON)

import Reflex.Dom.Core
import GHCJS.DOM.Types (MonadJSM, liftJSM)

import Reflex.Dom.Routing.Nested
import Reflex.Dom.Storage.Base
import Reflex.Dom.Storage.Class
import Reflex.Dom.Template

import State
import State.Exercise
import Types.Exercise
import Types.RouteFragment
import Types.Interactivity
import UI.Demonstration
import Util.Bootstrap
import Util.Scroll
import Util.Template

exerciseRule :: (MonadWidget t m, HasStorage t AppTags m, MonadReader Interactivity m)
             => Map Text (Exercise m)
             -> Rule m
exerciseRule m = elIdRule "div" $ \i -> do
  let
    (t1,t2) = Text.breakOn "-" i
    t3 = Text.drop 1 t2
  case t1 of
    "exercise" -> fmap mkExercise . Map.lookup t3 $ m
    _ -> Nothing

mkExercise :: (MonadWidget t m, HasStorage t AppTags m, MonadReader Interactivity m)
         => Exercise m
         -> m ()
mkExercise ex = elAttr "div" ("id" =: ("exercise-" <> _eId ex)) $ do
  dmExState <- askStorageTag ExerciseTag
  void . dyn $ mkExerciseState ex <$> dmExState

mkExerciseState :: (MonadWidget t m, HasStorage t AppTags m, MonadReader Interactivity m)
                => Exercise m
                -> Maybe ExerciseState
                -> m ()
mkExerciseState ex mst =
  let
    matches = maybe False ((== (_eId ex)) . esId) mst
    stage = if matches then maybe StageHidden esStage mst else StageHidden
  in
    case stage of
      StageProblem ->
        withTabs ex stage . problem . _eProblem $ ex
      StageProgress ->
        withTabs ex stage . progress . _eProgress $ ex
      StageSolution n ->
        withTabs ex stage . solution n $ ex
      StageHidden ->
        withoutTabs ex

withTabs :: (MonadWidget t m, HasStorage t AppTags m, MonadReader Interactivity m)
          => Exercise m
          -> ExerciseStage
          -> m ()
          -> m ()
withTabs ex stage w = divClass "card m-2" . divClass "card-body p-2" $ do
  let
    tab label value check = elClass "li" "nav-item" $ do
      let
        cls = ("nav-link" <>) . bool "" " active" . check $ stage
      (e, _) <- elClass' "a" cls $ text label
      pure $ value <$ domEvent Click e

  i <- ask
  let progressTitle = case i of
        Interactive -> "Progress"
        NonInteractive -> "Output"

  (eChange, eHide) <- elClass "ul" "nav nav-pills nav-fill m-1" $ do
    eGoal <- tab "Problem" StageProblem (has _StageProblem)
    eProgress <- tab progressTitle StageProgress (has _StageProgress)
    eSolution <- tab "Solution" (StageSolution 0) (has _StageSolution)
    eHide <- tab "Hide" StageHidden (has _StageHidden)

    let
      eChange = leftmost [eGoal, eProgress, eSolution]
    pure (eChange, eHide)

  tellStorageInsert ExerciseTag $ ExerciseState (_eId ex) <$> eChange
  tellStorageRemove ExerciseTag $ void eHide

  divClass "m-1" w

withoutTabs :: (MonadWidget t m, HasStorage t AppTags m)
            => Exercise m
            -> m ()
withoutTabs ex = divClass "m-2" . elClass "ul" "nav nav-pills nav-fill" $ do
  elClass "li" "nav-item" $ do
    (e, _) <- elClass' "a" "nav-link active" $ do
      text $ "Exercise: "
      text $ _eName ex
    tellStorageInsert ExerciseTag $ ExerciseState (_eId ex) StageProblem <$ domEvent Click e

problem :: (MonadWidget t m, MonadReader Interactivity m)
        => Problem m
        -> m ()
problem p = do
  divClass "alert alert-primary" $ do
    i <- ask
    case i of
      Interactive -> do
        text "To work on this exercise, open the file "
        el "code" $ text (_pExerciseFile p)
        text "."
      NonInteractive -> do
        text "To get set up to work through these exercises, click "
        elAttr "a" ("href" =: "https://github.com/qfpl/reflex-workshop") $ text "here"
        text "."
  void $ mkTemplate (demonstrationRule (_pDemonstrations p)) (_pPage p)

progress :: (MonadWidget t m, MonadReader Interactivity m)
         => Progress m
         -> m ()
progress (ProgressSetup display setup expected actual) = do
  x <- if display
      then do
        el "div" $ text "With the input:"
        card $ setup
      else
        setup
  el "div" $ text "the expected behavior is:"
  card $ expected x
  i <- ask
  when (i == Interactive) $ do
    el "div" $ text "and the actual behavior is:"
    card $ actual x
progress (ProgressNoSetup expected actual) = do
  el "div" $ text "The expected behavior is:"
  card $ expected
  i <- ask
  when (i == Interactive) $ do
    el "div" $ text "and the actual behavior is:"
    card $ actual

solution :: (MonadWidget t m, HasStorage t AppTags m)
         => Int
         -> Exercise m
         -> m ()
solution n ex =
  let
    Solution ts = _eSolution ex
    lastIx = length ts - 1
    solButton label fn check =
      if check n
      then do
        (el, _) <- elAttr' "button" ("type" =: "button" <> "class" =: "btn btn-primary") $ text label
        let e = domEvent Click el
        tellStorageInsert ExerciseTag $ ExerciseState (_eId ex) (StageSolution (fn n)) <$ e
      else
        elAttr "button" ("type" =: "button" <> "class" =: "btn btn-primary" <> "disabled" =: "") $ text label
  in
    if n < 0 || lastIx < n
    then blank
    else do
      divClass "d-flex flex-row justify-content-between p-1" $ do
        solButton "Previous" pred (/= 0)
        solButton "Next" succ (/= lastIx)

      void . el "div" $ mkTemplate mempty (ts !! n)
