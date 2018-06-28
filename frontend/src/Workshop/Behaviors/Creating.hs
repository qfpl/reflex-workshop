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
module Workshop.Behaviors.Creating (
    creatingSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.Behaviors.Creating.Fmap
import Workshop.Behaviors.Creating.Apply
import Workshop.Behaviors.Creating.Counter
import Workshop.Behaviors.Creating.Limit
import Workshop.Behaviors.Creating.Text

creatingSection :: MonadWidget t m => Section m
creatingSection =
  Section
    "Creating"
    (Page "creating")
    (static @ "pages/behaviors/creating.html")
    mempty
    mempty
    (Map.fromList [ ("fmap", exFmap)
                  , ("apply", exApply)
                  , ("counter", exCounter)
                  , ("limit", exLimit)
                  , ("text", exText)
                  ])
