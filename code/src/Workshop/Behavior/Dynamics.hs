{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Dynamics (
    dynamicsSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Behavior.Dynamics.Counter
import Workshop.Behavior.Dynamics.Unique

dynamicsSubSection :: MonadWidget t m => SubSection t m
dynamicsSubSection =
  SubSection "What is a Dynamic?" .
  runProblems "../pages/behaviors/dynamics.md" $
  [ counterProblem
  , uniqueProblem
  ]
