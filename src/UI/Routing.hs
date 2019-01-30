{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
module UI.Routing (
    mkMain
  ) where

import Control.Monad (void)

import Control.Monad.Reader (MonadReader)

import qualified Data.Map as Map

import Reflex.Dom.Core
import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Class

import State
import Types.Interactivity
import Types.RouteFragment
import Types.Section

import UI.Section

mkMain :: ( MonadWidget t m
          , RouteWriter t RouteFragment m
          , HasRoute t RouteFragment m
          , HasStorage t AppTags m
          , MonadReader Interactivity m
          )
       => [Section m]
       -> m ()
       -> m ()
mkMain sections d = do
  let
    routeMap = Map.fromList . fmap (\s -> (_sRoute s, s)) $ sections
  void . withRoute $ \route ->
    case route of
      Just p ->
        case Map.lookup p routeMap of
          Just s -> mkMain (_sSubSections s) $ mkSection s
          -- TODO replace this with an error page?
          Nothing -> tellRedirectLocally [Page "events"]
      _ ->
        d
