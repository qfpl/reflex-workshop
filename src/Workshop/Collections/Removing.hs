{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Collections.Removing (
    exRemoving
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Removing.List

exRemoving :: MonadWidget t m
             => Exercise m
exRemoving =
  let
    problem =
      Problem
        "pages/collections/removing.html"
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (todoListSolution tis) (todoListExercise tis)
    solution =
      Solution [
        "pages/collections/removing/solution/0.html"
      , "pages/collections/removing/solution/1.html"
      , "pages/collections/removing/solution/2.html"
      , "pages/collections/removing/solution/3.html"
      , "pages/collections/removing/solution/4.html"
      ]
  in
    Exercise
      "removing"
      "removing"
      problem
      progress
      solution
