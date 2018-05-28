{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Fmap (
    fmapProblem
  ) where

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import qualified Workshop.Behavior.Instances.Fmap.Exercise as I
import qualified Workshop.Behavior.Instances.Fmap.Solution as I

import Workshop.Behavior.Creating.Fmap.Exercise
import Workshop.Behavior.Creating.Fmap.Solution

mk :: MonadWidget t m
   => (Event t Int -> m (Behavior t Int))
   -> (Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn fnOld d = card $ do
  b <- fn (updated d)
  let
    eIn = b <@ updated d
    eOut = fnOld b <@ updated d
    collect = holdDyn "" . fmap (Text.pack .show)

  divClass "row" $ do
    divClass "col-6" $ text "Event in"
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
  pure $ Problem fmapGoal fmapEx "../pages/behaviors/creating/fmap/solution.md"

fmapGoal :: MonadWidget t m => m ()
fmapGoal =
  loadMarkdown "../pages/behaviors/creating/fmap/goal.md"

fmapEx :: MonadWidget t m => m ()
fmapEx = mdo
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time

  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/creating/fmap/exercise.md"
  a
  mk fmapExercise I.fmapExercise dIn
  b
  mk fmapSolution I.fmapSolution dIn
  c

  pure ()
