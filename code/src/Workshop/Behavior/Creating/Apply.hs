{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Apply (
    applyProblem
  ) where

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import qualified Workshop.Behavior.Instances.Apply.Exercise as I
import qualified Workshop.Behavior.Instances.Apply.Solution as I

import Workshop.Behavior.Creating.Apply.Exercise
import Workshop.Behavior.Creating.Apply.Solution

mk :: MonadWidget t m
   => (Event t Int -> m (Behavior t Int, Behavior t Int))
   -> (Behavior t Int -> Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn fnOld d = card $ do
  (b1, b2) <- fn (updated d)
  let
    eIn1 = b1 <@ updated d
    eIn2 = b2 <@ updated d
    eOut = fnOld b1 b2 <@ updated d
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
  pure $ Problem applyGoal applyEx "../pages/behaviors/creating/apply/solution.md"

applyGoal :: MonadWidget t m => m ()
applyGoal =
  loadMarkdown "../pages/behaviors/creating/apply/goal.md"

applyEx :: MonadWidget t m => m ()
applyEx = mdo
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/creating/apply/exercise.md"
  a
  mk applyExercise I.applyExercise dIn
  b
  mk applySolution I.applySolution dIn
  c

  pure ()
