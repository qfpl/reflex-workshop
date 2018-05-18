{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Filtering (
    filteringSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Event.Filtering.Ffilter
import Workshop.Event.Filtering.FmapMaybe

filteringSubSection :: MonadWidget t m => SubSection t m
filteringSubSection =
  SubSection "Filtering Events" .
  runProblems "../pages/events/filtering.md" $
  [ ffilterProblem
  , fmapMaybeProblem
  ]
