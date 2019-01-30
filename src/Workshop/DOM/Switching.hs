{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.DOM.Switching (
    switchingSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Types.Section
import Types.RouteFragment

import Workshop.DOM.Switching.HigherOrder
import Workshop.DOM.Switching.WidgetHold
import Workshop.DOM.Switching.Workflow
import Workshop.DOM.Switching.Todo

switchingSection :: MonadWidget t m => Section m
switchingSection =
  Section
    "Switching"
    (Page "switching")
    "pages/dom/switching.html"
    mempty
    mempty
    (Map.fromList [ ("higherOrder", exHigherOrder)
                  , ("widgetHold", exWidgetHold)
                  , ("workflow", exWorkflow)
                  , ("todo", exTodo)
                  ])
