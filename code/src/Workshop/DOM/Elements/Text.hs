{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Elements.Text (
    textProblem
  ) where

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Elements.Text.Exercise
import Workshop.DOM.Elements.Text.Solution

mk :: MonadWidget t m
   => (Dynamic t Int -> m ())
   -> Dynamic t Int
   -> m ()
mk fn dIn = card $
  fn dIn

textProblem :: MonadWidget t m => m (Problem t m)
textProblem =
  pure $ Problem textGoal textEx "../pages/dom/elements/text/solution.md"

textGoal :: MonadWidget t m => m ()
textGoal =
  loadMarkdown "../pages/dom/elements/text/goal.md"

textEx :: MonadWidget t m => m ()
textEx = mdo
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/dom/elements/text/exercise.md"
  a
  mk textExercise dIn
  b
  mk textSolution dIn
  c
