{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module UI.Section (
    mkSection
  ) where

import Control.Monad (void)
import Data.Semigroup ((<>))

import Control.Monad.Reader (MonadReader)

import Reflex.Dom
import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Class

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
  eDone <- mkTemplate rule (_sContentPath s)

  dmES <- askStorageTag ExerciseTag
  -- rule out changes if the id hasn't changed
  -- dmES' <- holdUniqDynBy ((==) `on` (fmap esId)) dmES
  imES <- sample . current $ dmES

  eDelay <- delay 0.1 eDone

  let
    f = maybe (pure ()) (scrollTo . ("exercise-" <>) . esId)
    eES = current dmES <@ eDelay

  void . widgetHold (f imES) $ f <$> eES -- leftmost [eES, updated $ dmES]

