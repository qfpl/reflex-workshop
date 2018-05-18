{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Limit (
    limitProblem
  ) where

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import qualified Workshop.Behavior.Querying.Limit.Exercise as Q
import qualified Workshop.Behavior.Querying.Limit.Solution as Q

import Workshop.Behavior.Creating.Limit.Exercise
import Workshop.Behavior.Creating.Limit.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Event t () -> Event t () -> m (Behavior t Int))
   -> (Behavior t Int -> Behavior t Int -> Event t () -> Event t () -> Event t Int)
   -> Event t ()
   -> Event t ()
   -> m (Event t (), Event t ())
mk fn fnOld eAddIn eClearIn = card $ mdo
  (eAddOut, eClearOut) <- divClass "row" $ do
    eA <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
    eC <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
    pure (eA, eC)

  let
    eAdd = leftmost [eAddIn, eAddOut]
    eClear = leftmost [eClearIn, eClearOut]

  dCount <- holdDyn 0 $ fnOld (current dCount) bLimit eAdd eClear
  bLimit <- fn (current dCount) eAdd eClear

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dCount

  pure (eAddOut, eClearOut)
limitProblem :: MonadWidget t m => m (Problem t m)
limitProblem =
  pure $ Problem limitGoal limitEx "../pages/behaviors/creating/limit/solution.md"

limitGoal :: MonadWidget t m => m ()
limitGoal =
  loadMarkdown "../pages/behaviors/creating/limit/goal.md"

limitEx :: MonadWidget t m => m ()
limitEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/creating/limit/exercise.md"
  a
  (eAddEx, eClearEx)   <- mk limitExercise Q.limitExercise eAddSol eClearSol
  b
  (eAddSol, eClearSol) <- mk limitSolution Q.limitSolution eAddEx eClearEx
  c

  pure ()
