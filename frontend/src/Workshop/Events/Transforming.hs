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
module Workshop.Events.Transforming (
    transformingSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.Events.Transforming.Fmap
import Workshop.Events.Transforming.FmapConst

transformingSection :: MonadWidget t m => Section m
transformingSection =
  Section
    "Transforming Events"
    (Page "transforming")
    (static @ "pages/events/transforming.html")
    mempty
    mempty
    (Map.fromList [("fmap", exFmap), ("fmapConst", exFmapConst)])
