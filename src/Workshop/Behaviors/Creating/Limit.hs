{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Creating.Limit (
    exLimit
  ) where

import Reflex.Dom

import Types.Exercise
import Util.Bootstrap

import qualified Exercises.Behaviors.Querying.Limit as Q
import qualified Solutions.Behaviors.Querying.Limit as Q

import Exercises.Behaviors.Creating.Limit
import Solutions.Behaviors.Creating.Limit

mkIn :: MonadWidget t m
     => m (Event t (), Event t ())
mkIn = divClass "row" $ do
  eAdd <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
  eClear <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
  pure (eAdd, eClear)

mk :: MonadWidget t m
   => (Behavior t Int -> Event t () -> Event t () -> m (Behavior t Int))
   -> (Behavior t Int -> Behavior t Int -> Event t () -> Event t () -> Event t Int)
   -> (Event t (), Event t ())
   -> m ()
mk fn fnOld (eAdd, eClear) = mdo
  dCount <- holdDyn 0 $ fnOld (current dCount) bLimit eAdd eClear
  bLimit <- fn (current dCount) eAdd eClear

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dCount

exLimit :: MonadWidget t m
        => Exercise m
exLimit =
  let
    problem =
      Problem
        "pages/behaviors/creating/limit.html"
        "src/Exercises/Behaviors/Creating/Limit.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk limitSolution Q.limitSolution) (mk limitExercise Q.limitExercise)
    solution =
      Solution [
        "pages/behaviors/creating/limit/solution/0.html"
      , "pages/behaviors/creating/limit/solution/1.html"
      , "pages/behaviors/creating/limit/solution/2.html"
      , "pages/behaviors/creating/limit/solution/3.html"
      , "pages/behaviors/creating/limit/solution/4.html"
      , "pages/behaviors/creating/limit/solution/5.html"
      ]
  in
    Exercise
      "limit"
      "limit"
      problem
      progress
      solution
