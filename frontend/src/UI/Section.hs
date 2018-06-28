{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
module UI.Section (
    mkSection
  ) where

import Control.Applicative ((<|>))
import Control.Monad (void)
import Data.Semigroup ((<>))

import Control.Monad.Reader (MonadReader)

import Reflex.Dom
import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Class
import Reflex.Dom.Template

import State
import State.Exercise
import Types.Interactivity
import Types.RouteFragment
import Types.Section
import UI.Demonstration
import UI.Exercise
import Util.Template
import Util.Scroll

mkSection :: ( MonadWidget t m
             , RouteWriter t RouteFragment m
             , HasRoute t RouteFragment m
             , HasStorage t AppTags m
             , MonadReader Interactivity m
             )
          => Section m
          -> m ()
mkSection s = do
  let
    rule = exerciseRule (_sExercises s) <> demonstrationRule (_sDemonstrations s)
  eDone <- template rule (_sContentPath s)

  dmES <- askStorageTag ExerciseTag
  eDelay <- delay 0.1 eDone
  let eES = fmapMaybe id $ current dmES <@ eDelay
  void . widgetHold blank $ scrollTo . ("exercise-" <>) . esId <$> eES -- leftmost [eES, fmapMaybe id . updated $ dmES]

