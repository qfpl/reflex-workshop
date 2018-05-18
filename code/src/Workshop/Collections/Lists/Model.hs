{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Collections.Lists.Model (
    modelProblem
  ) where

import Control.Lens

import Reflex.Dom.Core

import qualified Data.Map as Map

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.List
import Todo.Solution.List.Part10

mk :: MonadWidget t m
   => ([TodoItem] -> m (Dynamic t [TodoItem]))
   -> m ()
mk fn = card . divClass "row" $ do
  let
    items = [ TodoItem False "A"
            , TodoItem True "B"
            , TodoItem False "C"
            ]

  dItems <- divClass "col" $
    fn items

  let
    dComplete =
      fmap (view todoItem_text) . filter (view todoItem_complete) <$> dItems

  divClass "col" $ do
    el "div" . text $ "Completed items"
    el "ul" . simpleList dComplete $
      el "li" . dynText

  pure ()

modelProblem :: MonadWidget t m => m (Problem t m)
modelProblem =
  pure $ Problem modelGoal modelEx "../pages/collections/lists/model/solution.md"

modelGoal :: MonadWidget t m => m ()
modelGoal =
  loadMarkdown "../pages/collections/lists/model/goal.md"

modelEx :: MonadWidget t m => m ()
modelEx = do
  [a, b, c] <- loadMarkdownSingle "../pages/collections/lists/model/exercise.md"
  a
  mk todoListModelExercise
  b
  mk todoListModelSolution
  c
