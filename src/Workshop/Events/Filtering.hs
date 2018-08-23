{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Events.Filtering (
    filteringSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Types.Section
import Types.RouteFragment

import Workshop.Events.Filtering.Ffilter
import Workshop.Events.Filtering.FmapMaybe

filteringSection :: MonadWidget t m => Section m
filteringSection =
  Section
    "Filtering"
    (Page "filtering")
    "pages/events/filtering.html"
    mempty
    mempty
    (Map.fromList [("ffilter", exFfilter), ("fmapMaybe", exFmapMaybe)])
