{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
module Workshop.Collections.Lists.Displaying (
    exDisplaying
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Lists.Displaying.List

exDisplaying :: MonadWidget t m
             => Exercise m
exDisplaying =
  let
    problem =
      Problem
        (static @ "pages/collections/lists/displaying.html")
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (todoListSolution tis) (todoListExercise tis)
    solution =
      Solution [
        static @ "pages/collections/lists/displaying/solution/0.html"
      , static @ "pages/collections/lists/displaying/solution/1.html"
      , static @ "pages/collections/lists/displaying/solution/2.html"
      , static @ "pages/collections/lists/displaying/solution/3.html"
      ]
  in
    Exercise
      "displaying"
      "displaying"
      problem
      progress
      solution
