{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Instances.Apply (
    exApply
  ) where

import qualified Data.Text as Text

import Reflex.Dom.Core

import Types.Exercise

import Exercises.Behaviors.Instances.Apply
import Solutions.Behaviors.Instances.Apply

mkIn :: MonadWidget t m
     => m (Dynamic t Int, Dynamic t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  d <- count eTick

  let
    mkD n = (`div` n) <$> d
    d1 = mkD 2
    d2 = mkD 3

  let
    eIn1 = current d1 <@ updated d
    eIn2 = current d2 <@ updated d
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

  pure (d1, d2)

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int -> Behavior t Int)
   -> (Dynamic t Int, Dynamic t Int)
   -> m ()
mk fn (d1, d2) = do
  let
    eOut = fn (current d1) (current d2) <@ leftmost [updated d1, updated d2]
  dOut <- holdDyn "" . fmap (Text.pack . show) $ eOut

  divClass "row" $ do
    divClass "col-6" $ text "Behavior out"
    divClass "col-6" $ do
      dynText dOut

exApply :: MonadWidget t m
        => Exercise m
exApply =
  let
    problem =
      Problem
        "pages/behaviors/instances/apply.html"
        "src/Exercises/Behaviors/Instances/Apply.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk applySolution) (mk applyExercise)
    solution =
      Solution [
        "pages/behaviors/instances/apply/solution/0.html"
      , "pages/behaviors/instances/apply/solution/1.html"
      , "pages/behaviors/instances/apply/solution/2.html"
      , "pages/behaviors/instances/apply/solution/3.html"
      ]
  in
    Exercise
      "apply"
      "apply"
      problem
      progress
      solution
