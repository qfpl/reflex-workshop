{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Behavior (
    behaviorSection
  ) where

import Reflex.Dom.Core

import Util.Section

import Workshop.Behavior.Intro
import Workshop.Behavior.Instances
import Workshop.Behavior.Querying
import Workshop.Behavior.Creating
import Workshop.Behavior.Dynamics
import Workshop.Behavior.Components

behaviorSection :: MonadWidget t m => Section t m
behaviorSection =
  Section "Behaviors and Dynamics" [
    introSubSection
  , instancesSubSection
  , queryingSubSection
  , creatingSubSection
  , dynamicsSubSection
  , componentsSubSection
  ]
