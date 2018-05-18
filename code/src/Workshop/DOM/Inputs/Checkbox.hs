{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Inputs.Checkbox (
    checkboxProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.Item
import Todo.Solution.Item.Part2

mk :: MonadWidget t m
   => m a
   -> m a
mk = card

checkboxProblem :: MonadWidget t m => m (Problem t m)
checkboxProblem =
  pure $ Problem checkboxGoal checkboxEx "../pages/dom/inputs/checkbox/solution.md"

checkboxGoal :: MonadWidget t m => m ()
checkboxGoal =
  loadMarkdown "../pages/dom/inputs/checkbox/goal.md"

checkboxEx :: MonadWidget t m => m ()
checkboxEx = do
  let ti = TodoItem False "This is just a test"
  [a, b, c] <- loadMarkdownSingle "../pages/dom/inputs/checkbox/exercise.md"
  a
  mk $ todoItemExercise ti
  b
  mk $ todoItemSolution ti
  c
