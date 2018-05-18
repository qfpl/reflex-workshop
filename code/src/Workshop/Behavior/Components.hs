{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Components (
    componentsSubSection
  ) where

import Reflex.Dom.Core

import Util.File
import Util.Section

componentsSubSection :: MonadWidget t m => SubSection t m
componentsSubSection = SubSection "Components" $ \is -> do
  loadMarkdown "../pages/behaviors/components.md"
  pure never

