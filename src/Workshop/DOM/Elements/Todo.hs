{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Elements.Todo (
    exTodo
  ) where

import Reflex.Dom.Core

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
        "pages/dom/elements/todo.html"
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        "pages/dom/elements/todo/solution/0.html"
      , "pages/dom/elements/todo/solution/1.html"
      , "pages/dom/elements/todo/solution/2.html"
      , "pages/dom/elements/todo/solution/3.html"
      , "pages/dom/elements/todo/solution/4.html"
      , "pages/dom/elements/todo/solution/5.html"
      , "pages/dom/elements/todo/solution/6.html"
      , "pages/dom/elements/todo/solution/7.html"
      , "pages/dom/elements/todo/solution/8.html"
      , "pages/dom/elements/todo/solution/9.html"
      , "pages/dom/elements/todo/solution/10.html"
      ]
  in
    Exercise
      "todo"
      "todo"
      problem
      progress
      solution
