{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Inputs (
    inputsSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.DOM.Inputs.Checkbox
import Workshop.DOM.Inputs.TextInput

inputsSubSection :: MonadWidget t m => SubSection t m
inputsSubSection =
  SubSection "Inputs" .
  runProblems "../pages/dom/inputs.md" $
  [ checkboxProblem
  , textInputProblem
  ]
