{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Creating.Apply (
    exApply
  ) where

import qualified Data.Text as Text

import Reflex.Dom

import Types.Exercise
import Util.Bootstrap

import qualified Exercises.Behaviors.Instances.Apply as I
import qualified Solutions.Behaviors.Instances.Apply as I

import Exercises.Behaviors.Creating.Apply
import Solutions.Behaviors.Creating.Apply

mkIn :: MonadWidget t m
     => m (Dynamic t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dCount <- count eTick

  divClass "row" $ do
    divClass "col-6" $ text "Event in"
    divClass "col-6" $
      display dCount

  pure dCount

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

exApply :: MonadWidget t m
        => Exercise m
exApply =
  let
    problem =
      Problem
        "pages/behaviors/creating/apply.html"
        "src/Exercises/Behaviors/Creating/Apply.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk applySolution I.applySolution) (mk applyExercise I.applyExercise)
    solution =
      Solution [
        "pages/behaviors/creating/apply/solution/0.html"
      , "pages/behaviors/creating/apply/solution/1.html"
      , "pages/behaviors/creating/apply/solution/2.html"
      , "pages/behaviors/creating/apply/solution/3.html"
      , "pages/behaviors/creating/apply/solution/4.html"
      , "pages/behaviors/creating/apply/solution/5.html"
      , "pages/behaviors/creating/apply/solution/6.html"
      ]
  in
    Exercise
      "apply"
      "apply"
      problem
      progress
      solution
