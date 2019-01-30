{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Elements.Text (
    exText
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Elements.Text
import Solutions.DOM.Elements.Text


mkIn :: MonadWidget t m
     => m (Dynamic t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  count eTick

exText :: MonadWidget t m
       => Exercise m
exText =
  let
    problem =
      Problem
        "pages/dom/elements/text.html"
        "src/Exercises/DOM/Elements/Text.hs"
        mempty
    progress =
      ProgressSetup False mkIn textSolution textExercise
    solution =
      Solution [
        "pages/dom/elements/text/solution/0.html"
      , "pages/dom/elements/text/solution/1.html"
      , "pages/dom/elements/text/solution/2.html"
      , "pages/dom/elements/text/solution/3.html"
      , "pages/dom/elements/text/solution/4.html"
      , "pages/dom/elements/text/solution/5.html"
      ]
  in
    Exercise
      "text"
      "text"
      problem
      progress
      solution
