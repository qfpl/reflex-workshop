{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
module Workshop.Behaviors.Creating.Fmap (
    exFmap
  ) where

import qualified Data.Text as Text

import Reflex.Dom

import Static

import Types.Exercise
import Util.Bootstrap

import qualified Exercises.Behaviors.Instances.Fmap as I
import qualified Solutions.Behaviors.Instances.Fmap as I

import Exercises.Behaviors.Creating.Fmap
import Solutions.Behaviors.Creating.Fmap

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
   => (Event t Int -> m (Behavior t Int))
   -> (Behavior t Int -> Behavior t Int)
   -> Dynamic t Int
   -> m ()
mk fn fnOld d = card $ do
  b <- fn (updated d)
  let
    eIn = b <@ updated d
    eOut = fnOld b <@ updated d
    collect = holdDyn "" . fmap (Text.pack .show)

  divClass "row" $ do
    divClass "col-6" $ text "Behavior in"
    divClass "col-6" $ do
      dIn <- collect eIn
      dynText dIn

  divClass "row" $ do
    divClass "col-6" $ text "Behavior out"
    divClass "col-6" $ do
      dOut <- collect eOut
      dynText dOut

exFmap :: MonadWidget t m
       => Exercise m
exFmap =
  let
    problem =
      Problem
        (static @ "pages/behaviors/creating/fmap.html")
        "src/Exercises/Behaviors/Creating/Fmap.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk fmapSolution I.fmapSolution) (mk fmapExercise I.fmapExercise)
    solution =
      Solution [
        static @ "pages/behaviors/creating/fmap/solution/0.html"
      , static @ "pages/behaviors/creating/fmap/solution/1.html"
      ]
  in
    Exercise
      "fmap"
      "fmap"
      problem
      progress
      solution
