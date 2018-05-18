{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Initial (
    initialSection
  ) where

import Reflex.Dom.Core

import Util.Section
import Util.File

initialSection :: MonadWidget t m => Section t m
initialSection =
  Section "Introduction" [
    SubSection "Introducing reflex" $ \_ -> do
      loadMarkdown "../pages/introduction/reflex.md"
      pure never
  , SubSection "Introducing the workshop" $ \_ -> do
      loadMarkdown "../pages/introduction/workshop.md"
      pure never
  ]
