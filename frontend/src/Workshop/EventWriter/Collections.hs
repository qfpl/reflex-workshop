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
module Workshop.EventWriter.Collections (
    collectionsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Static

import Types.Section
import Types.RouteFragment

import Workshop.EventWriter.Collections.Removing

collectionsSection :: MonadWidget t m => Section m
collectionsSection =
  Section
    "Collections"
    (Page "collections")
    (static @ "pages/eventwriter/collections.html")
    mempty
    mempty
    (Map.fromList [ ("removing", exRemoving)
                  ])
