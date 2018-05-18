{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM (
    domSection
  ) where

import Reflex.Dom.Core

import Util.Section

import Workshop.DOM.Elements
import Workshop.DOM.Inputs
import Workshop.DOM.Switching

domSection :: MonadWidget t m => Section t m
domSection =
  Section "DOM" [
    elementsSubSection
  , inputsSubSection
  , switchingSubSection
  ]
