{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Dynamics.Unique (
    uniqueProblem
  ) where

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Dynamics.Unique.Exercise
import Workshop.Behavior.Dynamics.Unique.Solution

mk :: MonadWidget t m
   => (Dynamic t (Int, Int) -> m (Dynamic t Int, Dynamic t Int))
   -> Dynamic t Int
   -> m ()
mk fn dIn = card $ do
  let
    multiple n =
      (== 0) . (`mod` n)
    downsample n =
      fmap (`div` n) . ffilter (multiple n)
    eIn =
      updated dIn
    eIn1 =
      downsample 2 eIn
    eIn2 =
      downsample 3 eIn

  dIn1 <- holdDyn 0 eIn1
  dIn2 <- holdDyn 0 eIn2
  (dMid1, dMid2) <- fn $ (,) <$> dIn1 <*> dIn2

  let
    collect d =
      holdDyn "" .
      leftmost $ [
        Text.pack . show <$> updated d
      , "" <$ eIn
      ]

  dOut1 <- collect dMid1
  dOut2 <- collect dMid2

  divClass "row" $ do
    divClass "col-6" $ text "Input 1"
    divClass "col-6" $ display dIn1
  divClass "row" $ do
    divClass "col-6" $ text "Input 2"
    divClass "col-6" $ display dIn2
    divClass "col-6" $ text "Output 1"
    divClass "col-6" $ dynText dOut1
  divClass "row" $ do
    divClass "col-6" $ text "Output 2"
    divClass "col-6" $ dynText dOut2

uniqueProblem :: MonadWidget t m => m (Problem t m)
uniqueProblem =
  pure $ Problem uniqueGoal uniqueEx "../pages/behaviors/dynamics/unique/solution.md"

uniqueGoal :: MonadWidget t m => m ()
uniqueGoal =
  loadMarkdown "../pages/behaviors/dynamics/unique/goal.md"

uniqueEx :: MonadWidget t m => m ()
uniqueEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/dynamics/unique/exercise.md"
  a
  mk uniqueExercise dIn
  b
  mk uniqueSolution dIn
  c

  pure ()
