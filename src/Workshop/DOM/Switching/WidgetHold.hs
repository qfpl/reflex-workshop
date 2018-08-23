{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Switching.WidgetHold (
    exWidgetHold
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Switching.WidgetHold
import Solutions.DOM.Switching.WidgetHold

mkIn :: MonadWidget t m
     => m (Event t Bool)
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

  pure $ updated dClickable

mk :: MonadWidget t m
   => (Event t Bool -> m (Dynamic t Int))
   -> Event t Bool
   -> m ()
mk fn eIn = do
  dScore <- el "div" $
    fn eIn

  el "div" $ do
    text "Score: "
    display dScore

exWidgetHold :: MonadWidget t m
              => Exercise m
exWidgetHold =
  let
    problem =
      Problem
        "pages/dom/switching/widgetHold.html"
        "src/Exercises/DOM/Switching/WidgetHold.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk widgetHoldSolution) (mk widgetHoldExercise)
    solution =
      Solution [
        "pages/dom/switching/widgetHold/solution/0.html"
      , "pages/dom/switching/widgetHold/solution/1.html"
      , "pages/dom/switching/widgetHold/solution/2.html"
      , "pages/dom/switching/widgetHold/solution/3.html"
      , "pages/dom/switching/widgetHold/solution/4.html"
      , "pages/dom/switching/widgetHold/solution/5.html"
      , "pages/dom/switching/widgetHold/solution/6.html"
      ]
  in
    Exercise
      "widgetHold"
      "widgetHold"
      problem
      progress
      solution
