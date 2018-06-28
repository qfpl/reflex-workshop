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
module Workshop.Collections.Lists.Adding (
    exAdding
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Lists.Adding.List

exAdding :: MonadWidget t m
         => Exercise m
exAdding =
  let
    problem =
      Problem
        (static @ "pages/collections/lists/adding.html")
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (todoListSolution tis) (todoListExercise tis)
    solution =
      Solution [
        static @ "pages/collections/lists/adding/solution/0.html"
      , static @ "pages/collections/lists/adding/solution/1.html"
      , static @ "pages/collections/lists/adding/solution/2.html"
      , static @ "pages/collections/lists/adding/solution/3.html"
      , static @ "pages/collections/lists/adding/solution/4.html"
      , static @ "pages/collections/lists/adding/solution/5.html"
      , static @ "pages/collections/lists/adding/solution/6.html"
      ]
  in
    Exercise
      "adding"
      "adding"
      problem
      progress
      solution
