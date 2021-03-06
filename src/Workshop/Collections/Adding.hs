{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Collections.Adding (
    exAdding
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Adding.List

exAdding :: MonadWidget t m
         => Exercise m
exAdding =
  let
    problem =
      Problem
        "pages/collections/adding.html"
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (todoListSolution tis) (todoListExercise tis)
    solution =
      Solution [
        "pages/collections/adding/solution/0.html"
      , "pages/collections/adding/solution/1.html"
      , "pages/collections/adding/solution/2.html"
      , "pages/collections/adding/solution/3.html"
      , "pages/collections/adding/solution/4.html"
      , "pages/collections/adding/solution/5.html"
      , "pages/collections/adding/solution/6.html"
      ]
  in
    Exercise
      "adding"
      "adding"
      problem
      progress
      solution
