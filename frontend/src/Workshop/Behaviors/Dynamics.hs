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
module Workshop.Behaviors.Dynamics (
    dynamicsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.Behaviors.Dynamics.Counter
import Workshop.Behaviors.Dynamics.Unique

dynamicsSection :: MonadWidget t m => Section m
dynamicsSection =
  Section
    "Dynamics"
    (Page "dynamics")
    (static @ "pages/behaviors/dynamics.html")
    mempty
    mempty
    (Map.fromList [("counter", exCounter), ("unique", exUnique)])
