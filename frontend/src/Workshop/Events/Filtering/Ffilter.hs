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
module Workshop.Events.Filtering.Ffilter (
    exFfilter
  ) where

import qualified Data.Text as Text

import Reflex.Dom.Core

import Static

import Types.Exercise

import Exercises.Events.Filtering.Ffilter
import Solutions.Events.Filtering.Ffilter

mkIn :: MonadWidget t m => m (Event t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick

  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ display dIn

  pure $ updated dIn

mk :: MonadWidget t m => (Event t Int -> Event t Int) -> Event t Int -> m ()
mk fn eIn = do
  let
    eOut = fn eIn

  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ do
      dOut <- holdDyn "" .leftmost $ [ Text.pack . show <$> eOut, "" <$ eIn]
      dynText dOut

exFfilter :: MonadWidget t m
          => Exercise m
exFfilter =
  let
    problem =
      Problem
        (static @ "pages/events/filtering/ffilter.html")
        "src/Exercises/Events/Filtering/Ffilter.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk ffilterSolution) (mk ffilterExercise)
    solution =
      Solution [
        static @ "pages/events/filtering/ffilter/solution/0.html"
      , static @ "pages/events/filtering/ffilter/solution/1.html"
      , static @ "pages/events/filtering/ffilter/solution/2.html"
      , static @ "pages/events/filtering/ffilter/solution/3.html"
      , static @ "pages/events/filtering/ffilter/solution/4.html"
      ]
  in
    Exercise
      "ffilter"
      "ffilter"
      problem
      progress
      solution
