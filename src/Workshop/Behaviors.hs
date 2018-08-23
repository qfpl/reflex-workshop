{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behaviors (
    behaviorsSection
  ) where

import Reflex.Dom.Core

import Types.RouteFragment
import Types.Section

import Workshop.Behaviors.Instances
import Workshop.Behaviors.Querying
import Workshop.Behaviors.Creating
import Workshop.Behaviors.Dynamics
import Workshop.Behaviors.Components

behaviorsSection :: MonadWidget t m => Section m
behaviorsSection =
  Section
    "Behaviors"
    (Page "behaviors")
    "pages/behaviors.html"
    [instancesSection, queryingSection, creatingSection, dynamicsSection, componentsSection]
    mempty
    mempty
