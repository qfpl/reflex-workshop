{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Elements.Button (
    exButton
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Elements.Button
import Solutions.DOM.Elements.Button

mk :: MonadWidget t m
   => m a
   -> m a
mk =
  divClass "d-flex flex-row justify-content-between align-items-center"

exButton :: MonadWidget t m
         => Exercise m
exButton =
  let
    problem =
      Problem
        "pages/dom/elements/button.html"
        "src/Exercises/DOM/Elements/Button.hs"
        mempty
    progress =
      ProgressNoSetup (mk buttonSolution) (mk buttonExercise)
    solution =
      Solution [
        "pages/dom/elements/button/solution/0.html"
      , "pages/dom/elements/button/solution/1.html"
      , "pages/dom/elements/button/solution/2.html"
      , "pages/dom/elements/button/solution/3.html"
      , "pages/dom/elements/button/solution/4.html"
      ]
  in
    Exercise
      "button"
      "button"
      problem
      progress
      solution
