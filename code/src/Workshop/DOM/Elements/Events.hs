{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Events (
    eventsProblem
  ) where

import Control.Lens

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Elements.Events.Exercise
import Workshop.DOM.Elements.Events.Solution

mk :: MonadWidget t m
   => (Dynamic t Bool -> m () -> m (Event t ()))
   -> Event t Bool
   -> m (Event t Bool)
mk fn eIn = card $ mdo

  (dIn, eOut) <- divClass "row" $ do
    divClass "col-6" $
      text "Input"
    divClass "col-6" $ do
      cb <- checkbox False $
        def & checkboxConfig_setValue .~ leftmost [eIn, True <$ eClick]
      pure (cb ^. checkbox_value, cb ^. checkbox_change)

  eClick <- divClass "row" $ do
    divClass "col-6" $
      text "Output"
    divClass "col-6" $
      fn dIn $
        text "The checkbox should hide me"

  pure $ leftmost [eOut, True <$ eClick]

eventsProblem :: MonadWidget t m => m (Problem t m)
eventsProblem =
  pure $ Problem eventsGoal eventsEx "../pages/dom/elements/events/solution.md"

eventsGoal :: MonadWidget t m => m ()
eventsGoal =
  loadMarkdown "../pages/dom/elements/events/goal.md"

eventsEx :: MonadWidget t m => m ()
eventsEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/events/exercise.md"
  a
  eEx <- mk eventsExercise eSol
  b
  eSol <- mk eventsSolution eEx
  c
