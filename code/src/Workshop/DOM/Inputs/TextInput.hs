{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Inputs.TextInput (
    textInputProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.Item
import Todo.Solution.Item.Part3

mk :: MonadWidget t m
   => m a
   -> m a
mk = card

textInputProblem :: MonadWidget t m => m (Problem t m)
textInputProblem =
  pure $ Problem textInputGoal textInputEx "../pages/dom/inputs/textInput/solution.md"

textInputGoal :: MonadWidget t m => m ()
textInputGoal =
  loadMarkdown "../pages/dom/inputs/textInput/goal.md"

textInputEx :: MonadWidget t m => m ()
textInputEx = do
  let ti = TodoItem False "This is just a test"
  [a, b, c] <- loadMarkdownSingle "../pages/dom/inputs/textInput/exercise.md"
  a
  mk $ todoItemExercise ti
  b
  mk $ todoItemSolution ti
  c
