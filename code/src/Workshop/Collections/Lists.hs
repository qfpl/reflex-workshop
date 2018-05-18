{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Collections.Lists (
    listsSubSection
  ) where

import Reflex.Dom.Core

import Util.Exercises
import Util.Section

import Workshop.Collections.Lists.Displaying
import Workshop.Collections.Lists.Adding
import Workshop.Collections.Lists.Removing
import Workshop.Collections.Lists.Model

listsSubSection :: MonadWidget t m => SubSection t m
listsSubSection =
  SubSection "Lists" .
  runProblems "../pages/collections/lists.md" $
  [ displayingProblem
  , addingProblem
  , removingProblem
  , modelProblem
  ]
