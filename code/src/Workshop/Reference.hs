{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Reference (
    referenceSection
  ) where

import Reflex.Dom.Core

import Util.File
import Util.Section

referenceSection :: MonadWidget t m => Section t m
referenceSection =
  Section "Reference" [
    SubSection "reflex" $ \_ -> do
      loadMarkdown "../pages/reference/reflex.md"
      pure never
  , SubSection "reflex-dom" $ \_ -> do
      loadMarkdown "../pages/reference/reflex-dom.md"
      pure never
  ]
