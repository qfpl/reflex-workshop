{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.EventWriter (
    eventWriterSection
  ) where

import Reflex.Dom.Core

import Util.Section

import Workshop.EventWriter.Collections

eventWriterSection :: MonadWidget t m => Section t m
eventWriterSection =
  Section "EventWriter" [
    collectionsSubSection
  ]
