{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Class (
    classProblem
  ) where

import Control.Lens

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Elements.Class.Exercise
import Workshop.DOM.Elements.Class.Solution

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

classProblem :: MonadWidget t m => m (Problem t m)
classProblem =
  pure $ Problem classGoal classEx "../pages/dom/elements/class/solution.md"

classGoal :: MonadWidget t m => m ()
classGoal =
  loadMarkdown "../pages/dom/elements/class/goal.md"

classEx :: MonadWidget t m => m ()
classEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/class/exercise.md"
  a
  eEx <- mk classExercise eSol
  b
  eSol <- mk classSolution eEx
  c
