{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behaviors.Querying.Counter (
    exCounter
  ) where

import qualified Data.Text as Text

import Reflex.Dom

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Querying.Counter
import Solutions.Behaviors.Querying.Counter

mkIn :: MonadWidget t m
     => m (Event t (), Event t ())
mkIn = divClass "row" $ do
  eAdd <- divClass "col-6" $ buttonClass "Add" "btn btn-block"
  eClear <- divClass "col-6" $ buttonClass "Clear" "btn btn-block"
  pure (eAdd, eClear)

mk :: MonadWidget t m
   => (Behavior t Int -> Event t () -> Event t () -> Event t Int)
   -> (Event t (), Event t ())
   -> m ()
mk fn (eAdd, eClear) = mdo
  dOut <- holdDyn 0 $ fn (current dOut) eAdd eClear

  divClass "row" $ do
    divClass "col-6" $ text "Count"
    divClass "col-6" $ display dOut

exCounter :: MonadWidget t m
          => Exercise m
exCounter =
  let
    problem =
      Problem
        "pages/behaviors/querying/counter.html"
        "src/Exercises/Behaviors/Querying/Counter.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk counterSolution) (mk counterExercise)
    solution =
      Solution [
        "pages/behaviors/querying/counter/solution/0.html"
      , "pages/behaviors/querying/counter/solution/1.html"
      , "pages/behaviors/querying/counter/solution/2.html"
      , "pages/behaviors/querying/counter/solution/3.html"
      , "pages/behaviors/querying/counter/solution/4.html"
      , "pages/behaviors/querying/counter/solution/5.html"
      ]
  in
    Exercise
      "counter"
      "counter"
      problem
      progress
      solution
