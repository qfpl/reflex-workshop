{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Demo (
    demoSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Demo.Problems.Toggle

demoSection :: MonadWidget t m => Section t m
demoSection =
  Section "Workshop Demo" [
    SubSection "Testing out the workshop code" .
      runProblems "../pages/demo.md" $
      [ toggleProblem ]
  ]

