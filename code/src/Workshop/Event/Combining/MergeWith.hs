{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Combining.MergeWith (
    mergeWithProblem
  ) where

import Control.Lens

import Control.Monad.Trans (MonadIO(..))

import qualified Data.Text as Text

import Data.Time.Clock

import Reflex
import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Event.Combining.MergeWith.Exercise
import Workshop.Event.Combining.MergeWith.Solution

mk :: MonadWidget t m
   => (Event t Int -> Event t Int -> Event t Int)
   -> Event t Int
   -> Event t Int
   -> m ()
mk fn eIn1 eIn2 = card $ do
  let
    eOut = fn eIn1 eIn2

  let
    collect = holdDyn "" . fmap (Text.pack . show)
  dIn1 <- collect eIn1
  dIn2 <- collect eIn2
  dOut <- collect eOut

  divClass "row" $ do
    divClass "col-6" $ text "Input 1"
    divClass "col-6" $ dynText dIn1
  divClass "row" $ do
    divClass "col-6" $ text "Input 2"
    divClass "col-6" $ dynText dIn2
  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ dynText dOut

mergeWithProblem :: MonadWidget t m => m (Problem t m)
mergeWithProblem = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick

  let
    eIn = updated dIn
    eIn1 = (subtract 3) . (`mod` 6) <$> eIn
    eIn2 = (* 10) <$> eIn

  pure $ Problem (mergeWithGoal eIn1 eIn2) (mergeWithEx eIn1 eIn2) "../pages/events/combining/mergeWith/solution.md"

mergeWithGoal :: MonadWidget t m => Event t Int -> Event t Int -> m ()
mergeWithGoal eIn1 eIn2 = do
  dIn1 <- holdDyn "" $ Text.pack . show <$> eIn1
  dIn2 <- holdDyn "" $ Text.pack . show <$> eIn2
  [a, b] <- loadMarkdownSingle "../pages/events/combining/mergeWith/goal.md"
  a

  card $ do
    divClass "row" $ do
      divClass "col-6" $ text "Input 1"
      divClass "col-6" $ dynText dIn1
    divClass "row" $ do
      divClass "col-6" $ text "Input 2"
      divClass "col-6" $ dynText dIn2

  b

mergeWithEx :: MonadWidget t m => Event t Int -> Event t Int -> m ()
mergeWithEx eIn1 eIn2 = do
  [a, b] <- loadMarkdownSingle "../pages/events/combining/mergeWith/exercise.md"
  a
  mk mergeWithExercise eIn1 eIn2
  b
  mk mergeWithSolution eIn1 eIn2

