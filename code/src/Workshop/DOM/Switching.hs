{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Switching (
    switchingSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.DOM.Switching.HigherOrder
import Workshop.DOM.Switching.WidgetHold
import Workshop.DOM.Switching.Workflow
import Workshop.DOM.Switching.Todo

switchingSubSection :: MonadWidget t m => SubSection t m
switchingSubSection =
  SubSection "Switching" .
  runProblems "../pages/dom/switching.md" $
  [ higherOrderProblem
  , widgetHoldProblem
  , workflowProblem
  , todoProblem
  ]
