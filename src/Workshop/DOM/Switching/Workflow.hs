{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Switching.Workflow (
    exWorkflow
  ) where

import Reflex.Dom.Core

import Types.Exercise

import Exercises.DOM.Switching.Workflow
import Solutions.DOM.Switching.Workflow

mkIn :: MonadWidget t m
     => m (Event t ())
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dCount <- count eTick

  let
    eTick' = (`mod` 6) . negate <$> updated dCount
    eChange = () <$ ffilter (== 5) eTick'

  dTick <- holdDyn 0 eTick'
  el "div" $
    display dTick

  pure eChange

mk :: MonadWidget t m
   => (Event t () -> m (Dynamic t Int))
   -> Event t ()
   -> m ()
mk fn eChange = do
  dScore <- el "div" $
    fn eChange

  el "div" $ do
    text "Score: "
    display dScore

  pure ()
exWorkflow :: MonadWidget t m
              => Exercise m
exWorkflow =
  let
    problem =
      Problem
        "pages/dom/switching/workflow.html"
        "src/Exercises/DOM/Switching/Workflow.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk workflowSolution) (mk workflowExercise)
    solution =
      Solution [
        "pages/dom/switching/workflow/solution/0.html"
      , "pages/dom/switching/workflow/solution/1.html"
      , "pages/dom/switching/workflow/solution/2.html"
      , "pages/dom/switching/workflow/solution/3.html"
      ]
  in
    Exercise
      "workflow"
      "workflow"
      problem
      progress
      solution
