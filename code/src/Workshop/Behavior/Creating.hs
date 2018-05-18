{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Creating (
    creatingSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Behavior.Creating.Fmap
import Workshop.Behavior.Creating.Apply
import Workshop.Behavior.Creating.Counter
import Workshop.Behavior.Creating.Limit
import Workshop.Behavior.Creating.Text

creatingSubSection :: MonadWidget t m => SubSection t m
creatingSubSection =
  SubSection "Creating Behaviors" .
  runProblems "../pages/behaviors/creating.md" $
  [ fmapProblem
  , applyProblem
  , counterProblem
  , limitProblem
  , textProblem
  ]
