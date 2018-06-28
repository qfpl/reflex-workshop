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
module Workshop.EventWriter.Collections.Removing (
    exRemoving
  ) where

import Control.Monad (void)

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.EventWriter.Collections.Removing.List

exRemoving :: MonadWidget t m
           => Exercise m
exRemoving =
  let
    problem =
      Problem
        (static @ "pages/eventwriter/collections/removing.html")
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (void $ todoListModelSolution tis) (void $ todoListModelExercise tis)
    solution =
      Solution [
        static @ "pages/eventwriter/collections/removing/solution/0.html"
      , static @ "pages/eventwriter/collections/removing/solution/1.html"
      , static @ "pages/eventwriter/collections/removing/solution/2.html"
      ]
  in
    Exercise
      "removing"
      "removing"
      problem
      progress
      solution
