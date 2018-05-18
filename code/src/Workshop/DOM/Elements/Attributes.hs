{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Attributes (
    attributesProblem
  ) where

import Control.Lens

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Elements.Attributes.Exercise
import Workshop.DOM.Elements.Attributes.Solution

mk :: MonadWidget t m
   => (Dynamic t Bool -> m () -> m ())
   -> Event t Bool
   -> m (Event t Bool)
mk fn eIn = card $ do
  (dIn, eOut) <- divClass "row" $ do
    divClass "col-6" $
      text "Input"
    divClass "col-6" $ do
      cb <- checkbox False $ def & checkboxConfig_setValue .~ eIn
      pure (cb ^. checkbox_value, cb ^. checkbox_change)

  divClass "row" $ do
    divClass "col-6" $
      text "Output"
    divClass "col-6" $
      fn dIn $
        text "The checkbox should hide me"

  pure eOut

attributesProblem :: MonadWidget t m => m (Problem t m)
attributesProblem =
  pure $ Problem attributesGoal attributesEx "../pages/dom/elements/attributes/solution.md"

attributesGoal :: MonadWidget t m => m ()
attributesGoal =
  loadMarkdown "../pages/dom/elements/attributes/goal.md"

attributesEx :: MonadWidget t m => m ()
attributesEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/attributes/exercise.md"
  a
  eEx <- mk attributesExercise eSol
  b
  eSol <- mk attributesSolution eEx
  c
