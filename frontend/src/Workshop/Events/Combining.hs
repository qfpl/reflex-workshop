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
module Workshop.Events.Combining (
    combiningSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.Events.Combining.MergeWith
import Workshop.Events.Combining.Leftmost

combiningSection :: MonadWidget t m => Section m
combiningSection =
  Section
    "Combining Events"
    (Page "combining")
    (static @ "pages/events/combining.html")
    mempty
    mempty
    (Map.fromList [("mergeWith", exMergeWith), ("leftmost", exLeftmost)])
