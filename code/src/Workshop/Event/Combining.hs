{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Combining (
    combiningSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Event.Combining.MergeWith
import Workshop.Event.Combining.Leftmost

combiningSubSection :: MonadWidget t m => SubSection t m
combiningSubSection =
  SubSection "Combining Events" .
  runProblems "../pages/events/combining.md" $
  [ mergeWithProblem
  , leftmostProblem
  ]
