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
module Workshop.Events.Transforming.Fmap (
    exFmap
  ) where

import Control.Monad (void)

import qualified Data.Map as Map

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex.Dom.Core

import Static

import Types.Exercise
import Types.Demonstration

import Exercises.Events.Transforming.Fmap
import Solutions.Events.Transforming.Fmap

mkIn :: MonadWidget t m
     => m (Dynamic t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick
  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ display dIn
  pure dIn

mk :: MonadWidget t m
   => (Event t Int -> Event t Int)
   -> Dynamic t Int
   -> m ()
mk fn dIn = do
  let
    eIn = updated dIn
    eOut = fn eIn
  dOut <- holdDyn "" . fmap (Text.pack . show) $ eOut

  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ dynText dOut

demoCount :: MonadWidget t m
          => Demonstration m
demoCount =
  Demonstration "count" $ void mkIn

exFmap :: MonadWidget t m
       => Exercise m
exFmap =
  let
    problem =
      Problem
        (static @ "pages/events/transforming/fmap.html")
        "src/Exercises/Events/Transforming/Fmap.hs"
        (Map.fromList [("count", demoCount)])
    progress =
      ProgressSetup True mkIn (mk fmapSolution) (mk fmapExercise)
    solution =
      Solution [
        static @ "pages/events/transforming/fmap/solution/0.html"
      , static @ "pages/events/transforming/fmap/solution/1.html"
      , static @ "pages/events/transforming/fmap/solution/2.html"
      , static @ "pages/events/transforming/fmap/solution/3.html"
      ]
  in
    Exercise
      "fmap"
      "fmap"
      problem
      progress
      solution
