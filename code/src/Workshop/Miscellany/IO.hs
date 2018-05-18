{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Miscellany.IO (
    ioSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

ioSubSection :: MonadWidget t m => SubSection t m
ioSubSection =
  SubSection "IO" .
  runProblems "../pages/miscellany/io.md" $
  []
