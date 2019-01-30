{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Elements.Events (
    exEvents
  ) where

import Control.Lens

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Elements.Events
import Solutions.DOM.Elements.Events

mk :: MonadWidget t m
   => (Dynamic t Bool -> m () -> m (Event t ()))
   -> m ()
mk fn = mdo
  dIn <- divClass "row" $ do
    divClass "col-6" $
      text "Input"
    divClass "col-6" $ do
      cb <- checkbox False $
        def & checkboxConfig_setValue .~ (True <$ eClick)
      pure $ value cb

  eClick <- divClass "row" $ do
    divClass "col-6" $
      text "Output"
    divClass "col-6" $
      fn dIn $
        text "The checkbox should hide me"

  pure ()

exEvents :: MonadWidget t m
         => Exercise m
exEvents =
  let
    problem =
      Problem
        "pages/dom/elements/events.html"
        "src/Exercises/DOM/Elements/Events.hs"
        mempty
    progress =
      ProgressNoSetup (mk eventsSolution) (mk eventsExercise)
    solution =
      Solution [
        "pages/dom/elements/events/solution/0.html"
      , "pages/dom/elements/events/solution/1.html"
      , "pages/dom/elements/events/solution/2.html"
      , "pages/dom/elements/events/solution/3.html"
      ]
  in
    Exercise
      "events"
      "events"
      problem
      progress
      solution
