{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Collections.EventWriter.Removing (
    exRemoving
  ) where

import Control.Monad (void)

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.EventWriter.Removing.List

exRemoving :: MonadWidget t m
           => Exercise m
exRemoving =
  let
    problem =
      Problem
        "pages/collections/eventwriter/removing.html"
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (void $ todoListModelSolution tis) (void $ todoListModelExercise tis)
    solution =
      Solution [
        "pages/collections/eventwriter/removing/solution/0.html"
      , "pages/collections/eventwriter/removing/solution/1.html"
      , "pages/collections/eventwriter/removing/solution/2.html"
      ]
  in
    Exercise
      "removing"
      "removing"
      problem
      progress
      solution
