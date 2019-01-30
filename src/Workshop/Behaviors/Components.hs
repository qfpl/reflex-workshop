{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Components (
    componentsSection
  ) where

import Reflex.Dom.Core

import Types.Section
import Types.RouteFragment

componentsSection :: MonadWidget t m => Section m
componentsSection =
  Section
    "Components"
    (Page "components")
    "pages/behaviors/components.html"
    mempty
    mempty
    mempty
