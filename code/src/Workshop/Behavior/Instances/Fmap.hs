{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Instances.Fmap (
    fmapProblem
  ) where

import Control.Lens

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Instances.Fmap.Exercise
import Workshop.Behavior.Instances.Fmap.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn d = card $ do
  let
    eIn = current d <@ updated d
    eOut = fn (current d) <@ updated d
    collect = holdDyn "" . fmap (Text.pack .show)

  divClass "row" $ do
    divClass "col-6" $ text "Behavior in"
    divClass "col-6" $ do
      dIn <- collect eIn
      dynText dIn

  divClass "row" $ do
    divClass "col-6" $ text "Behavior out"
    divClass "col-6" $ do
      dOut <- collect eOut
      dynText dOut

fmapProblem :: MonadWidget t m => m (Problem t m)
fmapProblem =
  pure $ Problem fmapGoal fmapEx "../pages/behaviors/instances/fmap/solution.md"

fmapGoal :: MonadWidget t m => m ()
fmapGoal =
  loadMarkdown "../pages/behaviors/instances/fmap/goal.md"

fmapEx :: MonadWidget t m => m ()
fmapEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/instances/fmap/exercise.md"
  a
  mk fmapExercise dIn
  b
  mk fmapSolution dIn
  c

