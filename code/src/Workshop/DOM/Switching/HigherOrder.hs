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
module Workshop.DOM.Switching.HigherOrder (
    higherOrderProblem
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

import Workshop.DOM.Switching.HigherOrder.Exercise
import Workshop.DOM.Switching.HigherOrder.Solution

mk :: MonadWidget t m
   => (Event t Bool -> Event t () -> m (Dynamic t Int))
   -> Event t Int
   -> m ()
mk fn eIn = card $ mdo
  let
    eTick = (`mod` 6) . negate <$> eIn
  let
    eChange = ffilter (== 5) eTick
  dClickable <- toggle False eChange

  dScore <- fn (updated dClickable) eClick

  dTick <- holdDyn 0 eTick
  el "div" $
    display dTick

  let
    dLabel = bool "Wait..." "Click me" <$> dClickable

  eClick <- el "div" $
    dynButtonClass dLabel "btn"

  el "div" $ do
    text "Score: "
    display dScore

  pure ()

higherOrderProblem :: MonadWidget t m => m (Problem t m)
higherOrderProblem =
  pure $ Problem higherOrderGoal higherOrderEx "../pages/dom/switching/higherOrder/solution.md"

higherOrderGoal :: MonadWidget t m => m ()
higherOrderGoal =
  loadMarkdown "../pages/dom/switching/higherOrder/goal.md"

higherOrderEx :: MonadWidget t m => m ()
higherOrderEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick
  let eIn = updated dIn

  [a, b, c] <- loadMarkdownSingle "../pages/dom/switching/higherOrder/exercise.md"
  a
  mk higherOrderExercise eIn
  b
  mk higherOrderSolution eIn
  c
