{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event (
    eventSection
  ) where

import Reflex.Dom.Core

import Util.Section
import Util.File

import Workshop.Event.Transforming
import Workshop.Event.Filtering
import Workshop.Event.Combining

eventSection :: MonadWidget t m => Section t m
eventSection =
  Section "Events" [
      SubSection "What is an Event?" $ \_ -> do
        loadMarkdown "../pages/events/intro.md"
        pure never
    , transformingSubSection
    , filteringSubSection
    , combiningSubSection
    ]

