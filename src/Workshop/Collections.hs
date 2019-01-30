{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Collections (
    collectionsSection
  ) where

import Reflex.Dom.Core

import qualified Data.Map as Map

import Types.RouteFragment
import Types.Section

import Workshop.Collections.Displaying
import Workshop.Collections.Adding
import Workshop.Collections.Removing
import Workshop.Collections.Model
import Workshop.Collections.EventWriter

collectionsSection :: MonadWidget t m => Section m
collectionsSection =
  Section
    "Collections"
    (Page "collections")
    "pages/collections.html"
    [eventWriterSection]
    mempty
    (Map.fromList [ ("displaying", exDisplaying)
                  , ("adding", exAdding)
                  , ("removing", exRemoving)
                  , ("model", exModel)
                  ])
