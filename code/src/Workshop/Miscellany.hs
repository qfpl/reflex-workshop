{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Miscellany (
    miscellanySection
  ) where

import Reflex.Dom.Core

import Util.Section

import Workshop.Miscellany.IO
import Workshop.Miscellany.Time
import Workshop.Miscellany.Servant
import Workshop.Miscellany.Websockets

miscellanySection :: MonadWidget t m => Section t m
miscellanySection =
  Section "Miscellany" [
    ioSubSection
  , timeSubSection
  , servantSubSection
  , websocketsSubSection
  ]
