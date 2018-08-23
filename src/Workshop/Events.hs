{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Events (
    eventsSection
  ) where

import Reflex.Dom.Core

import Types.RouteFragment
import Types.Section

import Workshop.Events.Transforming
import Workshop.Events.Filtering
import Workshop.Events.Combining

eventsSection :: MonadWidget t m => Section m
eventsSection =
  Section
    "Events"
    (Page "events")
    "pages/events.html"
    [transformingSection, filteringSection, combiningSection]
    mempty
    mempty
