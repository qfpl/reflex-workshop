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
module Workshop.DOM.Elements.Todo (
    exTodo
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.Item
import Solutions.Todo.DOM.Elements.Item

exTodo :: MonadWidget t m
       => Exercise m
exTodo =
  let
    problem =
      Problem
        (static @ "pages/dom/elements/todo.html")
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        static @ "pages/dom/elements/todo/solution/0.html"
      , static @ "pages/dom/elements/todo/solution/1.html"
      , static @ "pages/dom/elements/todo/solution/2.html"
      , static @ "pages/dom/elements/todo/solution/3.html"
      , static @ "pages/dom/elements/todo/solution/4.html"
      , static @ "pages/dom/elements/todo/solution/5.html"
      , static @ "pages/dom/elements/todo/solution/6.html"
      , static @ "pages/dom/elements/todo/solution/7.html"
      , static @ "pages/dom/elements/todo/solution/8.html"
      , static @ "pages/dom/elements/todo/solution/9.html"
      , static @ "pages/dom/elements/todo/solution/10.html"
      ]
  in
    Exercise
      "todo"
      "todo"
      problem
      progress
      solution
