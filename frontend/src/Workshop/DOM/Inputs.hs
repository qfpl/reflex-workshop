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
module Workshop.DOM.Inputs (
    inputsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.DOM.Inputs.Checkbox
import Workshop.DOM.Inputs.TextInput

inputsSection :: MonadWidget t m => Section m
inputsSection =
  Section
    "Inputs"
    (Page "inputs")
    (static @ "pages/dom/inputs.html")
    mempty
    mempty
    (Map.fromList [ ("checkbox", exCheckbox)
                  , ("textInput", exTextInput)
                  ])
