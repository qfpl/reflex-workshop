{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE RankNTypes #-}
module Workshop.DOM.Switching.Workflow (
    workflowProblem
  ) where

import Data.Bool

import Control.Monad.Trans (MonadIO(..))
import Data.Time.Clock

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.DOM.Switching.Workflow.Exercise
import Workshop.DOM.Switching.Workflow.Solution

mk :: MonadWidget t m
   => (Event t () -> m (Dynamic t Int))
   -> Event t Int
   -> m ()
mk fn eIn = card $ mdo
  let
    eTick = (`mod` 6) . negate <$> eIn
  let
    eChange = () <$ ffilter (== 5) eTick

  dTick <- holdDyn 0 eTick
  el "div" $
    display dTick

  dScore <- el "div" $
    fn eChange

  el "div" $ do
    text "Score: "
    display dScore

  pure ()

workflowProblem :: MonadWidget t m => m (Problem t m)
workflowProblem =
  pure $ Problem workflowGoal workflowEx "../pages/dom/switching/workflow/solution.md"

workflowGoal :: MonadWidget t m => m ()
workflowGoal =
  loadMarkdown "../pages/dom/switching/workflow/goal.md"

workflowEx :: MonadWidget t m => m ()
workflowEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick
  let eIn = updated dIn

  [a, b, c] <- loadMarkdownSingle "../pages/dom/switching/workflow/exercise.md"
  a
  mk workflowExercise eIn
  b
  mk workflowSolution eIn
  c
