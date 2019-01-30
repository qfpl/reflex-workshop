{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Collections.EventWriter (
    eventWriterSection
  ) where

import Reflex.Dom.Core

import qualified Data.Map as Map

import Types.RouteFragment
import Types.Section

import Workshop.Collections.EventWriter.Removing

eventWriterSection :: MonadWidget t m => Section m
eventWriterSection =
  Section
    "EventWriter"
    (Page "eventWriter")
    "pages/collections/eventwriter.html"
    mempty
    mempty
    (Map.fromList [ ("removing", exRemoving)
                  ])
