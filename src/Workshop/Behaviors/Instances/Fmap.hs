{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Instances.Fmap (
    exFmap
  ) where

import qualified Data.Text as Text

import Reflex.Dom.Core

import Types.Exercise

import Exercises.Behaviors.Instances.Fmap
import Solutions.Behaviors.Instances.Fmap

mkIn :: MonadWidget t m
     => m (Dynamic t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  d <- count eTick

  let
    eIn = current d <@ updated d
  dIn <- holdDyn "" . fmap (Text.pack . show) $ eIn

  divClass "row" $ do
    divClass "col-6" $ text "Behavior in"
    divClass "col-6" $ do
      dynText dIn

  pure d

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn d = do
  let
    eOut = fn (current d) <@ updated d
  dOut <- holdDyn "" . fmap (Text.pack . show) $ eOut

  divClass "row" $ do
    divClass "col-6" $ text "Behavior out"
    divClass "col-6" $ do
      dynText dOut

exFmap :: MonadWidget t m
       => Exercise m
exFmap =
  let
    problem =
      Problem
        "pages/behaviors/instances/fmap.html"
        "src/Exercises/Behaviors/Instances/Fmap.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk fmapSolution) (mk fmapExercise)
    solution =
      Solution [
        "pages/behaviors/instances/fmap/solution/0.html"
      , "pages/behaviors/instances/fmap/solution/1.html"
      , "pages/behaviors/instances/fmap/solution/2.html"
      , "pages/behaviors/instances/fmap/solution/3.html"
      ]
  in
    Exercise
      "fmap"
      "fmap"
      problem
      progress
      solution
