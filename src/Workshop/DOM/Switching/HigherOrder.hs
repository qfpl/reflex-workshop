{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.DOM.Switching.HigherOrder (
    exHigherOrder
  ) where

import Data.Bool (bool)

import Reflex.Dom.Core

import Types.Exercise
import Util.Bootstrap

import Exercises.DOM.Switching.HigherOrder
import Solutions.DOM.Switching.HigherOrder

mkIn :: MonadWidget t m
     => m (Dynamic t Bool)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dCount <- count eTick

  let
    eTick' = (`mod` 6) . negate <$> updated dCount
    eChange = ffilter (== 5) eTick'
  dClickable <- toggle False eChange

  dTick <- holdDyn 0 eTick'
  el "div" $
    display dTick

  pure dClickable

mk :: MonadWidget t m
   => (Event t Bool -> Event t () -> m (Dynamic t Int))
   -> Dynamic t Bool
   -> m ()
mk fn dClickable = mdo
  dScore <- fn (updated dClickable) eClick

  let
    dLabel = bool "Wait..." "Click me" <$> dClickable

  eClick <- el "div" $
    dynButtonClass dLabel "btn"

  el "div" $ do
    text "Score: "
    display dScore

exHigherOrder :: MonadWidget t m
              => Exercise m
exHigherOrder =
  let
    problem =
      Problem
        "pages/dom/switching/higherOrder.html"
        "src/Exercises/DOM/Switching/HigherOrder.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk higherOrderSolution) (mk higherOrderExercise)
    solution =
      Solution [
        "pages/dom/switching/higherOrder/solution/0.html"
      , "pages/dom/switching/higherOrder/solution/1.html"
      , "pages/dom/switching/higherOrder/solution/2.html"
      , "pages/dom/switching/higherOrder/solution/3.html"
      , "pages/dom/switching/higherOrder/solution/4.html"
      , "pages/dom/switching/higherOrder/solution/5.html"
      , "pages/dom/switching/higherOrder/solution/6.html"
      ]
  in
    Exercise
      "higherOrder"
      "higherOrder"
      problem
      progress
      solution
