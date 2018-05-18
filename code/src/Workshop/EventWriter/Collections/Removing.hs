{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.EventWriter.Collections.Removing (
    removingProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.List
import Todo.Solution.List.Part9

removingProblem :: MonadWidget t m => m (Problem t m)
removingProblem =
  pure $ Problem removingGoal removingEx "../pages/eventwriter/collections/removing/solution.md"

removingGoal :: MonadWidget t m => m ()
removingGoal =
  loadMarkdown "../pages/eventwriter/collections/removing/goal.md"

removingEx :: MonadWidget t m => m ()
removingEx = do
  let
    items = [ TodoItem False "A"
            , TodoItem True "B"
            , TodoItem False "C"
            ]
  [a, b, c] <- loadMarkdownSingle "../pages/eventwriter/collections/removing/exercise.md"
  a
  card $ todoListExercise items
  b
  card $ todoListSolution items
  c
