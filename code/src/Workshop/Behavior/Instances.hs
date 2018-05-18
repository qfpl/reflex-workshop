{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior.Instances (
    instancesSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Behavior.Instances.Fmap
import Workshop.Behavior.Instances.Apply

instancesSubSection :: MonadWidget t m => SubSection t m
instancesSubSection =
  SubSection "Instances for Behavior" .
  runProblems "../pages/behaviors/instances.md" $
  [ fmapProblem
  , applyProblem
  ]
