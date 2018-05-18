{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Querying.Limit (
    limitProblem
  ) where

import Control.Lens

import Control.Monad.Trans (liftIO)

import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Querying.Limit.Exercise
import Workshop.Behavior.Querying.Limit.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int -> Event t () -> Event t () -> Event t Int)
   -> Event t ()
   -> Event t ()
   -> m (Event t (), Event t ())
mk fn eAddIn eClearIn = card $ mdo
  (eAddOut, eClearOut) <- divClass "row" $ do
    eA <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
    eC <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
    pure (eA, eC)

  let
    eAdd = leftmost [eAddIn, eAddOut]
    eClear = leftmost [eClearIn, eClearOut]

  dCount <- holdDyn 0 $ fn (current dCount) (current dLimit) eAdd eClear

  let
    defaultLimit = 5

  bLimitIncrease <- hold False . leftmost $ [
      False <$ eClear
    , (==) <$> current dCount <*> current dLimit <@ eAdd
    ]
  bLastClear <- hold False . leftmost $ [
      True <$ eClear
    , False <$ eAdd
    ]

  dLimit <- foldDyn ($) defaultLimit . mergeWith (.) $
    [ (+1) <$ gate bLimitIncrease eClear
    , const defaultLimit <$ gate bLastClear eClear
    ]

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dCount

  pure (eAddOut, eClearOut)

limitProblem :: MonadWidget t m => m (Problem t m)
limitProblem = 
  pure $ Problem limitGoal limitEx "../pages/behaviors/querying/limit/solution.md"

limitGoal :: MonadWidget t m => m ()
limitGoal =
  loadMarkdown "../pages/behaviors/querying/limit/goal.md"

limitEx :: MonadWidget t m => m ()
limitEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/querying/limit/exercise.md"
  a
  (eAddEx, eClearEx)   <- mk limitExercise eAddSol eClearSol
  b
  (eAddSol, eClearSol) <- mk limitSolution eAddEx eClearEx
  c

