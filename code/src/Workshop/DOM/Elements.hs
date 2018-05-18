{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Elements (
    elementsSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.DOM.Elements.Text
import Workshop.DOM.Elements.Class
import Workshop.DOM.Elements.Attributes
import Workshop.DOM.Elements.Events
import Workshop.DOM.Elements.Button
import Workshop.DOM.Elements.Todo

elementsSubSection :: MonadWidget t m => SubSection t m
elementsSubSection =
  SubSection "Elements" .
  runProblems "../pages/dom/elements.md" $
  [ textProblem
  , classProblem
  , attributesProblem
  , eventsProblem
  , buttonProblem
  , todoProblem
  ]
