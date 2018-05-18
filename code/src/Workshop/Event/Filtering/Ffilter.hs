{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Filtering.Ffilter (
    ffilterProblem
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

import Workshop.Event.Filtering.Ffilter.Exercise
import Workshop.Event.Filtering.Ffilter.Solution

mk :: MonadWidget t m => (Event t Int -> Event t Int) -> Event t Int -> m ()
mk fn eIn = card $ do
  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ do
      dIn <- holdDyn "" $ Text.pack . show <$> eIn
      dynText dIn

  let
    eOut = fn eIn

  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ do
      dOut <- holdDyn "" .leftmost $ [ Text.pack . show <$> eOut, "" <$ eIn]
      dynText dOut

ffilterProblem :: MonadWidget t m => m (Problem t m)
ffilterProblem = 
  pure $ Problem ffilterGoal ffilterEx "../pages/events/filtering/ffilter/solution.md"

ffilterGoal :: MonadWidget t m => m ()
ffilterGoal =
  loadMarkdown "../pages/events/filtering/ffilter/goal.md"

ffilterEx :: MonadWidget t m => m ()
ffilterEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- count eTick
  let eIn = updated dIn

  [a, b] <- loadMarkdownSingle "../pages/events/filtering/ffilter/exercise.md"

  a
  mk ffilterExercise eIn
  b
  mk ffilterSolution eIn

