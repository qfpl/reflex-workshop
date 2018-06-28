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
module Workshop.DOM.Inputs.Checkbox (
    exCheckbox
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.Item
import Solutions.Todo.DOM.Inputs.Checkbox.Item

exCheckbox :: MonadWidget t m
           => Exercise m
exCheckbox =
  let
    problem =
      Problem
        (static @ "pages/dom/inputs/checkbox.html")
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        static @ "pages/dom/inputs/checkbox/solution/0.html"
      , static @ "pages/dom/inputs/checkbox/solution/1.html"
      , static @ "pages/dom/inputs/checkbox/solution/2.html"
      , static @ "pages/dom/inputs/checkbox/solution/3.html"
      , static @ "pages/dom/inputs/checkbox/solution/4.html"
      , static @ "pages/dom/inputs/checkbox/solution/5.html"
      , static @ "pages/dom/inputs/checkbox/solution/6.html"
      , static @ "pages/dom/inputs/checkbox/solution/7.html"
      , static @ "pages/dom/inputs/checkbox/solution/8.html"
      , static @ "pages/dom/inputs/checkbox/solution/9.html"
      ]
  in
    Exercise
      "checkbox"
      "checkbox"
      problem
      progress
      solution
