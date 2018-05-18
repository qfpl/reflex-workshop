{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Querying (
    queryingSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Behavior.Querying.Tag
import Workshop.Behavior.Querying.Counter
import Workshop.Behavior.Querying.CounterText
import Workshop.Behavior.Querying.Limit

queryingSubSection :: MonadWidget t m => SubSection t m
queryingSubSection =
  SubSection "Querying Behaviors" .
  runProblems "../pages/behaviors/querying.md" $
  [ tagProblem
  , counterProblem
  , counterTextProblem
  , limitProblem
  ]
