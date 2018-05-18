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
module Workshop.DOM.Switching.WidgetHold (
    widgetHoldProblem
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

import Workshop.DOM.Switching.WidgetHold.Exercise
import Workshop.DOM.Switching.WidgetHold.Solution

mk :: MonadWidget t m
   => (Event t Bool -> m (Dynamic t Int))
   -> Event t Int
   -> m ()
mk fn eIn = card $ mdo
  let
    eTick = (`mod` 6) . negate <$> eIn
  let
    eChange = ffilter (== 5) eTick
  dClickable <- toggle False eChange

  dTick <- holdDyn 0 eTick
  el "div" $
    display dTick

  dScore <- el "div" $
    fn (updated dClickable)

  el "div" $ do
    text "Score: "
    display dScore

  pure ()

widgetHoldProblem :: MonadWidget t m => m (Problem t m)
widgetHoldProblem =
  pure $ Problem widgetHoldGoal widgetHoldEx "../pages/dom/switching/widgetHold/solution.md"

widgetHoldGoal :: MonadWidget t m => m ()
widgetHoldGoal =
  loadMarkdown "../pages/dom/switching/widgetHold/goal.md"

widgetHoldEx :: MonadWidget t m => m ()
widgetHoldEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick
  let eIn = updated dIn

  [a, b, c] <- loadMarkdownSingle "../pages/dom/switching/widgetHold/exercise.md"
  a
  mk widgetHoldExercise eIn
  b
  mk widgetHoldSolution eIn
  c
