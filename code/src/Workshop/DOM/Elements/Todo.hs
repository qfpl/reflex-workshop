{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Todo (
    todoProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.Item
import Todo.Solution.Item.Part1

mk :: MonadWidget t m
   => m a
   -> m a
mk = card

todoProblem :: MonadWidget t m => m (Problem t m)
todoProblem =
  pure $ Problem todoGoal todoEx "../pages/dom/elements/todo/solution.md"

todoGoal :: MonadWidget t m => m ()
todoGoal =
  loadMarkdown "../pages/dom/elements/todo/goal.md"

todoEx :: MonadWidget t m => m ()
todoEx = do
  let ti = TodoItem False "This is just a test"
  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/todo/exercise.md"
  a
  mk $ todoItemExercise ti
  b
  mk $ todoItemSolution ti
  c
