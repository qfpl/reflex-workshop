{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Collections.Lists (
    listsSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Types.Section
import Types.RouteFragment

import Workshop.Collections.Lists.Displaying
import Workshop.Collections.Lists.Adding
import Workshop.Collections.Lists.Removing
import Workshop.Collections.Lists.Model

listsSection :: MonadWidget t m => Section m
listsSection =
  Section
    "Lists"
    (Page "lists")
    "pages/collections/lists.html"
    mempty
    mempty
    (Map.fromList [ ("displaying", exDisplaying)
                  , ("adding", exAdding)
                  , ("removing", exRemoving)
                  , ("model", exModel)
                  ])
