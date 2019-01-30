{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Inputs.TextInput (
    exTextInput
  ) where

import Reflex.Dom.Core

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
        "pages/dom/inputs/textInput.html"
        "src/Exercises/Todo/Item.hs"
        mempty
    progress =
      let ti = TodoItem False "This is just a test"
      in ProgressNoSetup (todoItemSolution ti) (todoItemExercise ti)
    solution =
      Solution [
        "pages/dom/inputs/textInput/solution/0.html"
      , "pages/dom/inputs/textInput/solution/1.html"
      , "pages/dom/inputs/textInput/solution/2.html"
      , "pages/dom/inputs/textInput/solution/3.html"
      , "pages/dom/inputs/textInput/solution/4.html"
      , "pages/dom/inputs/textInput/solution/5.html"
      , "pages/dom/inputs/textInput/solution/6.html"
      , "pages/dom/inputs/textInput/solution/7.html"
      , "pages/dom/inputs/textInput/solution/8.html"
      , "pages/dom/inputs/textInput/solution/9.html"
      ]
  in
    Exercise
      "textInput"
      "textInput"
      problem
      progress
      solution
