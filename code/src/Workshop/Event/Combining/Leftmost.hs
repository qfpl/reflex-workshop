{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Combining.Leftmost (
    leftmostProblem
  ) where

import Control.Lens

import Control.Monad.Trans (MonadIO(..))

import Data.Text (Text)
import qualified Data.Text as Text

import Data.Time.Clock

import Reflex
import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Event.Combining.Leftmost.Exercise
import Workshop.Event.Combining.Leftmost.Solution

mk :: MonadWidget t m
   => (Event t Int -> (Event t Text, Event t Text, Event t Text, Event t Text))
   -> Event t Int
   -> m ()
mk fn eIn = card $ do

  let
    (eFizz, eBuzz, eFizzBuzz, eSolution) = fn eIn

  dIn <- holdDyn 0 eIn
  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ display dIn

  dFizz <- holdDyn "" eFizz
  divClass "row" $ do
    divClass "col-6" $ text "Fizz"
    divClass "col-6" $ dynText dFizz

  dBuzz <- holdDyn "" eBuzz
  divClass "row" $ do
    divClass "col-6" $ text "Buzz"
    divClass "col-6" $ dynText dBuzz

  dFizzBuzz <- holdDyn "" eFizzBuzz
  divClass "row" $ do
    divClass "col-6" $ text "FizzBuzz"
    divClass "col-6" $ dynText dFizzBuzz

  dSolution <- holdDyn "" eSolution
  divClass "row" $ do
    divClass "col-6" $ text "Solution"
    divClass "col-6" $ dynText dSolution

leftmostProblem :: MonadWidget t m => m (Problem t m)
leftmostProblem =
  pure $ Problem leftmostGoal leftmostEx "../pages/events/combining/leftmost/solution.md"

leftmostGoal :: MonadWidget t m => m ()
leftmostGoal =
  loadMarkdown "../pages/events/combining/leftmost/goal.md"

leftmostEx :: MonadWidget t m => m ()
leftmostEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time

  dIn <- count eTick

  let
    eIn = updated dIn

  [a, b] <- loadMarkdownSingle "../pages/events/combining/leftmost/exercise.md"
  a
  mk leftmostExercise eIn
  b
  mk leftmostSolution eIn

