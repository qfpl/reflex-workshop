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
module Workshop.Collections (
    collectionsSection
  ) where

import Reflex.Dom.Core
import Static

import Types.RouteFragment
import Types.Section

import Workshop.Collections.Lists

collectionsSection :: MonadWidget t m => Section m
collectionsSection =
  Section
    "Collections"
    (Page "collections")
    (static @ "pages/collections.html")
    [listsSection]
    mempty
    mempty
