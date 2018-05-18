{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Collections.Lists.Displaying (
    displayingProblem
  ) where

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Todo.Common
import Todo.Exercise.List
import Todo.Solution.List.Part6

displayingProblem :: MonadWidget t m => m (Problem t m)
displayingProblem =
  pure $ Problem displayingGoal displayingEx "../pages/collections/lists/displaying/solution.md"

displayingGoal :: MonadWidget t m => m ()
displayingGoal =
  loadMarkdown "../pages/collections/lists/displaying/goal.md"

displayingEx :: MonadWidget t m => m ()
displayingEx = do
  let
    items = [ TodoItem False "A"
            , TodoItem True "B"
            , TodoItem False "C"
            ]
  [a, b, c] <- loadMarkdownSingle "../pages/collections/lists/displaying/exercise.md"
  a
  card $ todoListExercise items
  b
  card $ todoListSolution items
  c
