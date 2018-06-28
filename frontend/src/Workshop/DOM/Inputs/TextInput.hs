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
module Workshop.DOM.Inputs.TextInput (
    exTextInput
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Common.Todo
import Exercises.Todo.Item
import Solutions.Todo.DOM.Inputs.TextInput.Item

exTextInput :: MonadWidget t m
            => Exercise m
exTextInput =
  let
    problem =
      Problem
        (static @ "pages/dom/inputs/textInput.html")
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        static @ "pages/dom/inputs/textInput/solution/0.html"
      , static @ "pages/dom/inputs/textInput/solution/1.html"
      , static @ "pages/dom/inputs/textInput/solution/2.html"
      , static @ "pages/dom/inputs/textInput/solution/3.html"
      , static @ "pages/dom/inputs/textInput/solution/4.html"
      , static @ "pages/dom/inputs/textInput/solution/5.html"
      , static @ "pages/dom/inputs/textInput/solution/6.html"
      , static @ "pages/dom/inputs/textInput/solution/7.html"
      , static @ "pages/dom/inputs/textInput/solution/8.html"
      , static @ "pages/dom/inputs/textInput/solution/9.html"
      ]
  in
    Exercise
      "textInput"
      "textInput"
      problem
      progress
      solution
