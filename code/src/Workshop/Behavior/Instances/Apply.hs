{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Instances.Apply (
    applyProblem
  ) where

import Control.Lens

import Control.Monad.Trans (liftIO)

import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Instances.Apply.Exercise
import Workshop.Behavior.Instances.Apply.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn d = card $ do
  let
    mkD n = holdDyn 0 . fmap (`div` n) . ffilter ((== 0) . (`mod` n)) . updated $ d
  d1 <- mkD 2
  d2 <- mkD 3
  let
    eIn1 = current d1 <@ updated d
    eIn2 = current d2 <@ updated d
    eOut = fn (current d1) (current d2) <@ updated d
    collect = holdDyn "" . fmap (Text.pack .show)

  divClass "row" $ do
    divClass "col-6" $ text "Behavior in 1"
    divClass "col-6" $ do
      dIn <- collect eIn1
      dynText dIn

  divClass "row" $ do
    divClass "col-6" $ text "Behavior in 2"
    divClass "col-6" $ do
      dIn <- collect eIn2
      dynText dIn

  divClass "row" $ do
    divClass "col-6" $ text "Behavior out"
    divClass "col-6" $ do
      dOut <- collect eOut
      dynText dOut

applyProblem :: MonadWidget t m => m (Problem t m)
applyProblem =
  pure $ Problem applyGoal applyEx "../pages/behaviors/instances/apply/solution.md"

applyGoal :: MonadWidget t m => m ()
applyGoal =
  loadMarkdown "../pages/behaviors/instances/apply/goal.md"

applyEx :: MonadWidget t m => m ()
applyEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/instances/apply/exercise.md"
  a
  mk applyExercise dIn
  b
  mk applySolution dIn
  c

