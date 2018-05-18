{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Button (
    buttonProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Elements.Button.Exercise
import Workshop.DOM.Elements.Button.Solution

mk :: MonadWidget t m
   => m a
   -> m a
mk =
  card .
  divClass "d-flex flex-row justify-content-between align-items-center"

buttonProblem :: MonadWidget t m => m (Problem t m)
buttonProblem =
  pure $ Problem buttonGoal buttonEx "../pages/dom/elements/button/solution.md"

buttonGoal :: MonadWidget t m => m ()
buttonGoal =
  loadMarkdown "../pages/dom/elements/button/goal.md"

buttonEx :: MonadWidget t m => m ()
buttonEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/button/exercise.md"
  a
  mk buttonExercise
  b
  mk buttonSolution
  c
