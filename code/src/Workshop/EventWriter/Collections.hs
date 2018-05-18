{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.EventWriter.Collections (
    collectionsSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.EventWriter.Collections.Removing

collectionsSubSection :: MonadWidget t m => SubSection t m
collectionsSubSection =
  SubSection "Collections" .
  runProblems "../pages/eventwriter/collections.md" $
  [ removingProblem ]
