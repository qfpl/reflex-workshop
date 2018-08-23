{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Elements.Class (
    exClass
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Elements.Class
import Solutions.DOM.Elements.Class

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

exClass :: MonadWidget t m
        => Exercise m
exClass =
  let
    problem =
      Problem
        "pages/dom/elements/class.html"
        "src/Exercises/DOM/Elements/Class.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk classSolution) (mk classExercise)
    solution =
      Solution [
        "pages/dom/elements/class/solution/0.html"
      , "pages/dom/elements/class/solution/1.html"
      , "pages/dom/elements/class/solution/2.html"
      , "pages/dom/elements/class/solution/3.html"
      , "pages/dom/elements/class/solution/4.html"
      ]
  in
    Exercise
      "class"
      "class"
      problem
      progress
      solution
