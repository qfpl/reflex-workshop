{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Intro (
    introSubSection
  ) where

import Reflex.Dom.Core

import Util.File
import Util.Section

introSubSection :: MonadWidget t m => SubSection t m
introSubSection = SubSection "What is a Behavior?" $ \_ -> do
  loadMarkdown "../pages/behaviors/intro.md"
  pure never
