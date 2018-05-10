{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Demo.Problems.Toggle (
    toggleProblem
  ) where

import Control.Monad.Trans (MonadIO(..))
import Data.Time.Clock

import Data.Text (Text)

import Reflex.Dom.Core

import Util.File
import Util.Exercises
import Util.Bootstrap

import Workshop.Demo.Problems.Toggle.Exercise
import Workshop.Demo.Problems.Toggle.Solution

mk :: MonadWidget t m => Text -> Text -> Event t Bool -> m ()
mk l r eb = card $ do
  dl <- holdDyn "" . leftmost $ [l <$ ffilter id eb, "" <$ eb]
  dr <- holdDyn "" . leftmost $ [r <$ ffilter not eb, "" <$ eb]
  divClass "row" $ do
    divClass "col-6" $ text "Output 1"
    divClass "col-6" $ dynText dl
  divClass "row" $ do
    divClass "col-6" $ text "Output 2"
    divClass "col-6" $ dynText dr

toggleProblem :: MonadWidget t m => m (Problem t m)
toggleProblem = pure $ Problem toggleGoal toggleEx toggleSol

toggleGoal :: MonadWidget t m => m ()
toggleGoal =
  loadMarkdown "../pages/demo/problems/toggle/goal.md"

toggleEx :: MonadWidget t m => m ()
toggleEx = do
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time
  dIn <- toggle False eTick
  let eIn = updated dIn

  [a, b, c] <- loadMarkdownSingle "../pages/demo/problems/toggle/exercise.md"
  a
  mk toggleExercise1 toggleExercise2 eIn
  b
  mk toggleSolution1 toggleSolution2 eIn
  c

toggleSol :: MonadWidget t m => Int -> m (Event t Int)
toggleSol =
  solution
    "../pages/demo/problems/toggle/solution.md"
