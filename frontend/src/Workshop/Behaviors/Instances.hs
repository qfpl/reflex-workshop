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
module Workshop.Behaviors.Instances (
    instancesSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.Behaviors.Instances.Fmap
import Workshop.Behaviors.Instances.Apply

instancesSection :: MonadWidget t m => Section m
instancesSection =
  Section
    "Instances"
    (Page "instances")
    (static @ "pages/behaviors/instances.html")
    mempty
    mempty
    (Map.fromList [("fmap", exFmap), ("apply", exApply)])
