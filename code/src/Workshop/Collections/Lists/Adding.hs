{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Collections.Lists.Adding (
    addingProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.List
import Todo.Solution.List.Part7

addingProblem :: MonadWidget t m => m (Problem t m)
addingProblem =
  pure $ Problem addingGoal addingEx "../pages/collections/lists/adding/solution.md"

addingGoal :: MonadWidget t m => m ()
addingGoal =
  loadMarkdown "../pages/collections/lists/adding/goal.md"

addingEx :: MonadWidget t m => m ()
addingEx = do
  let
    items = [ TodoItem False "A"
            , TodoItem True "B"
            , TodoItem False "C"
            ]
  [a, b, c] <- loadMarkdownSingle "../pages/collections/lists/adding/exercise.md"
  a
  card $ todoListExercise items
  b
  card $ todoListSolution items
  c
