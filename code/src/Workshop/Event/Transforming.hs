{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Event.Transforming (
    transformingSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Event.Transforming.Fmap
import Workshop.Event.Transforming.FmapConst

transformingSubSection :: MonadWidget t m => SubSection t m
transformingSubSection =
  SubSection "Transforming Events" .
  runProblems "../pages/events/transforming.md" $
  [ fmapProblem
  , fmapConstProblem
  ]
