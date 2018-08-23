{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Collections.Displaying (
    exDisplaying
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Displaying.List

exDisplaying :: MonadWidget t m
             => Exercise m
exDisplaying =
  let
    problem =
      Problem
        "pages/collections/displaying.html"
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (todoListSolution tis) (todoListExercise tis)
    solution =
      Solution [
        "pages/collections/displaying/solution/0.html"
      , "pages/collections/displaying/solution/1.html"
      , "pages/collections/displaying/solution/2.html"
      , "pages/collections/displaying/solution/3.html"
      ]
  in
    Exercise
      "displaying"
      "displaying"
      problem
      progress
      solution
