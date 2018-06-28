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
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behaviors.Dynamics.Counter (
    exCounter
  ) where

import Reflex.Dom

import Static

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Dynamics.Counter
import Solutions.Behaviors.Dynamics.Counter

mkIn :: MonadWidget t m
     => m (Event t (), Event t ())
mkIn = divClass "row" $ do
  eAdd <- divClass "col-6" $ buttonClass "Add" "btn btn-block"
  eClear <- divClass "col-6" $ buttonClass "Clear" "btn btn-block"
  pure (eAdd, eClear)

mk :: MonadWidget t m
   => (Event t (Int -> Int) -> m (Dynamic t Int))
   -> (Event t (), Event t ())
   -> m ()
mk fn (eAdd, eClear) = mdo
  let
    eFn = leftmost [ (+ 1) <$ eAdd, const 0 <$ eClear]

  d <- fn eFn

  divClass "row" $ do
    divClass "col-6" $ text "Count"
    divClass "col-6" $ display d

exCounter :: MonadWidget t m
          => Exercise m
exCounter =
  let
    problem =
      Problem
        (static @ "pages/behaviors/dynamics/counter.html")
        "src/Exercises/Behaviors/Dynamics/Counter.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk counterSolution) (mk counterExercise)
    solution =
      Solution [
        static @ "pages/behaviors/dynamics/counter/solution/0.html"
      , static @ "pages/behaviors/dynamics/counter/solution/1.html"
      , static @ "pages/behaviors/dynamics/counter/solution/2.html"
      , static @ "pages/behaviors/dynamics/counter/solution/3.html"
      ]
  in
    Exercise
      "counter"
      "counter"
      problem
      progress
      solution
