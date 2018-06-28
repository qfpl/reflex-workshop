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
module Workshop.DOM.Elements.Attributes (
    exAttributes
  ) where

import Reflex.Dom.Core

import Static

import Types.Exercise

import Exercises.DOM.Elements.Attributes
import Solutions.DOM.Elements.Attributes

mkIn :: MonadWidget t m
     => m (Dynamic t Bool)
mkIn = divClass "row" $ do
  divClass "col-6" $
    text "Input"
  divClass "col-6" $ do
    cb <- checkbox False def
    pure $ value cb

mk :: MonadWidget t m
   => (Dynamic t Bool -> m () -> m ())
   -> Dynamic t Bool
   -> m ()
mk fn dIn = divClass "row" $ do
  divClass "col-6" $
    text "Output"
  divClass "col-6" $
    fn dIn $
      text "The checkbox should hide me"

exAttributes :: MonadWidget t m
             => Exercise m
exAttributes =
  let
    problem =
      Problem
        (static @ "pages/dom/elements/attributes.html")
        "src/Exercises/DOM/Elements/Attributes.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk attributesSolution) (mk attributesExercise)
    solution =
      Solution [
        static @ "pages/dom/elements/attributes/solution/0.html"
      , static @ "pages/dom/elements/attributes/solution/1.html"
      , static @ "pages/dom/elements/attributes/solution/2.html"
      , static @ "pages/dom/elements/attributes/solution/3.html"
      ]
  in
    Exercise
      "attributes"
      "attributes"
      problem
      progress
      solution
