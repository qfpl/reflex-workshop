{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behaviors.Querying (
    queryingSection
  ) where

import qualified Data.Map as Map

import Reflex.Dom.Core

import Types.Section
import Types.RouteFragment

import Workshop.Behaviors.Querying.Tag
import Workshop.Behaviors.Querying.Counter
import Workshop.Behaviors.Querying.CounterText
import Workshop.Behaviors.Querying.Limit

queryingSection :: MonadWidget t m => Section m
queryingSection =
  Section
    "Querying"
    (Page "querying")
    "pages/behaviors/querying.html"
    mempty
    mempty
    (Map.fromList [("tag", exTag), ("counter", exCounter), ("counterText", exCounterText), ("limit", exLimit)])
