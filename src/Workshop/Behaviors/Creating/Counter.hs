{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Creating.Counter (
    exCounter
  ) where

import Reflex.Dom

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Creating.Counter
import Solutions.Behaviors.Creating.Counter

mkIn :: MonadWidget t m
   => m (Event t (), Event t ())
mkIn = divClass "row" $ do
  eAdd <- divClass "col-6" $ buttonClass "Add" "btn btn-block"
  eClear <- divClass "col-6" $ buttonClass "Clear" "btn btn-block"
  pure (eAdd, eClear)

mk :: MonadWidget t m
   => (Event t (Int -> Int) -> m (Behavior t Int, Event t Int))
   -> (Event t (), Event t ())
   -> m ()
mk fn (eAdd, eClear) = do
  let
    eFn = leftmost [ (+ 1) <$ eAdd, const 0 <$ eClear]

  (b, e) <- fn eFn
  let
    d = unsafeDynamic b e

  divClass "row" $ do
    divClass "col-6" $ text "Count"
    divClass "col-6" $ display d

exCounter :: MonadWidget t m
        => Exercise m
exCounter =
  let
    problem =
      Problem
        "pages/behaviors/creating/counter.html"
        "src/Exercises/Behaviors/Creating/Counter.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk counterSolution) (mk counterExercise)
    solution =
      Solution [
        "pages/behaviors/creating/counter/solution/0.html"
      , "pages/behaviors/creating/counter/solution/1.html"
      , "pages/behaviors/creating/counter/solution/2.html"
      ]
  in
    Exercise
      "counter"
      "counter"
      problem
      progress
      solution
