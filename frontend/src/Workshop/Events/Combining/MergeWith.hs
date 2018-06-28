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
module Workshop.Events.Combining.MergeWith (
    exMergeWith
  ) where

import Control.Monad (void)

import qualified Data.Map as Map
import qualified Data.Text as Text

import Reflex.Dom.Core

import Static

import Types.Exercise
import Types.Demonstration

import Exercises.Events.Combining.MergeWith
import Solutions.Events.Combining.MergeWith

mkIn :: MonadWidget t m => m (Event t Int, Event t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick

  let
    eIn = updated dIn
    eIn1 = (subtract 3) . (`mod` 6) <$> eIn
    eIn2 = (* 10) <$> eIn

  dIn1 <- holdDyn "" $ Text.pack . show <$> eIn1
  dIn2 <- holdDyn "" $ Text.pack . show <$> eIn2

  do
    divClass "row" $ do
      divClass "col-6" $ text "Input 1"
      divClass "col-6" $ dynText dIn1
    divClass "row" $ do
      divClass "col-6" $ text "Input 2"
      divClass "col-6" $ dynText dIn2

  pure (eIn1, eIn2)

mk :: MonadWidget t m
   => (Event t Int -> Event t Int -> Event t Int)
   -> (Event t Int, Event t Int)
   -> m ()
mk fn (eIn1, eIn2) = do
  let
    eOut = fn eIn1 eIn2

  dOut <- holdDyn "" . fmap (Text.pack . show) $ eOut

  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ dynText dOut

demoEvents :: MonadWidget t m => Demonstration m
demoEvents =
  Demonstration "events" $ void mkIn

exMergeWith :: MonadWidget t m
            => Exercise m
exMergeWith =
  let
    problem =
      Problem
        (static @ "pages/events/combining/mergeWith.html")
        "src/Exercises/Events/Combining/MergeWith.hs"
        (Map.fromList [("events", demoEvents)])
    progress =
      ProgressSetup True mkIn (mk mergeWithSolution) (mk mergeWithExercise)
    solution =
      Solution [
        static @ "pages/events/combining/mergeWith/solution/0.html"
      , static @ "pages/events/combining/mergeWith/solution/1.html"
      , static @ "pages/events/combining/mergeWith/solution/2.html"
      , static @ "pages/events/combining/mergeWith/solution/3.html"
      , static @ "pages/events/combining/mergeWith/solution/4.html"
      , static @ "pages/events/combining/mergeWith/solution/5.html"
      ]
  in
    Exercise
      "mergeWith"
      "mergeWith"
      problem
      progress
      solution
