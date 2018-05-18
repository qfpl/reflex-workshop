{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Transforming.Fmap (
    fmapProblem
  ) where

import Control.Monad.Trans (MonadIO(..))
import Data.Time.Clock

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex
import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Event.Transforming.Fmap.Exercise
import Workshop.Event.Transforming.Fmap.Solution

mkIn :: MonadWidget t m => Dynamic t Int -> m ()
mkIn dIn =
  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ display dIn

mkOut :: MonadWidget t m => Dynamic t Text -> m ()
mkOut dOut =
  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ dynText dOut

mk :: MonadWidget t m => (Event t Int -> Event t Int) -> Dynamic t Int -> m ()
mk fn dIn = do
  let
    eIn = updated dIn
    eOut = fn eIn
  dOut <- holdDyn "" . fmap (Text.pack . show) $ eOut

  card $ do
    mkIn dIn
    mkOut dOut

fmapProblem :: MonadWidget t m => m (Problem t m)
fmapProblem = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  pure $ Problem (fmapGoal dIn) (fmapEx dIn) "../pages/events/transforming/fmap/solution.md"

fmapGoal :: MonadWidget t m => Dynamic t Int -> m ()
fmapGoal dIn = do
  [a, b] <- loadMarkdownSingle "../pages/events/transforming/fmap/goal.md"
  a
  card $ mkIn dIn
  b

fmapEx :: MonadWidget t m => Dynamic t Int -> m ()
fmapEx dIn = do
  [a, b] <- loadMarkdownSingle "../pages/events/transforming/fmap/exercise.md"

  a
  mk fmapExercise dIn
  b
  mk fmapSolution dIn

