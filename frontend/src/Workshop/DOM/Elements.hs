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
module Workshop.DOM.Elements (
    elementsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.DOM.Elements.Text
import Workshop.DOM.Elements.Class
import Workshop.DOM.Elements.Attributes
import Workshop.DOM.Elements.Button
import Workshop.DOM.Elements.Events
import Workshop.DOM.Elements.Todo

elementsSection :: MonadWidget t m => Section m
elementsSection =
  Section
    "Elements"
    (Page "elements")
    (static @ "pages/dom/elements.html")
    mempty
    mempty
    (Map.fromList [ ("text", exText)
                  , ("class", exClass)
                  , ("attributes", exAttributes)
                  , ("button", exButton)
                  , ("events", exEvents)
                  , ("todo", exTodo)
                  ])
