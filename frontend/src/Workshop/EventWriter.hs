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
module Workshop.EventWriter (
    eventWriterSection
  ) where

import Reflex.Dom.Core
import Static

import Types.RouteFragment
import Types.Section

import Workshop.EventWriter.Collections

eventWriterSection :: MonadWidget t m => Section m
eventWriterSection =
  Section
    "EventWriter"
    (Page "eventWriter")
    (static @ "pages/eventwriter.html")
    [collectionsSection]
    mempty
    mempty
