{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Switching.Todo (
    exTodo
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.Item
import Solutions.Todo.DOM.Switching.Item

exTodo :: MonadWidget t m
       => Exercise m
exTodo =
  let
    problem =
      Problem
        "pages/dom/switching/todo.html"
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        "pages/dom/switching/todo/solution/0.html"
      , "pages/dom/switching/todo/solution/1.html"
      , "pages/dom/switching/todo/solution/2.html"
      , "pages/dom/switching/todo/solution/3.html"
      , "pages/dom/switching/todo/solution/4.html"
      , "pages/dom/switching/todo/solution/5.html"
      ]
  in
    Exercise
      "todo"
      "todo"
      problem
      progress
      solution
