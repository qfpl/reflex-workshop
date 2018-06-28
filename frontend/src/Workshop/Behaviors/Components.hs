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
module Workshop.Behaviors.Components (
    componentsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

-- import Workshop.Behaviors.Components.Fmap
-- import Workshop.Behaviors.Components.FmapConst

componentsSection :: MonadWidget t m => Section m
componentsSection =
  Section
    "Components"
    (Page "components")
    (static @ "pages/behaviors/components.html")
    mempty
    mempty
    mempty
    -- (Map.fromList [("fmap", exFmap), ("fmapConst", exFmapConst)])
