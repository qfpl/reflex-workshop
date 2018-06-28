{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}
module UI.Menu (
    mkMenu
  ) where

import Control.Monad (void)
import Data.Bool (bool)
import Data.Foldable (traverse_)
import Data.List (isPrefixOf)
import Data.Semigroup ((<>))

import Control.Monad.Trans (lift, liftIO)
import Control.Monad.Reader (ReaderT, runReaderT, local, ask)

import qualified Data.Text as Text

import Reflex.Dom.Core
import Reflex.Dom.Routing.Nested
import Reflex.Dom.Routing.Writer
import Reflex.Dom.Storage.Class

import State
import Types.RouteFragment
import Types.Section

mkMenu :: (MonadWidget t m, RouteWriter t RouteFragment m, HasRoute t RouteFragment m, HasStorage t AppTags m)
       => [Section m]
       -> m ()
mkMenu = flip runReaderT [] . mkMenu'

mkMenu' :: (MonadWidget t m, RouteWriter t RouteFragment m, HasRoute t RouteFragment m, HasStorage t AppTags m)
        => [Section m]
        -> ReaderT [RouteFragment] m ()
mkMenu' sections = do
  dRoute <- lift allRouteSegments
  iRoute <- ask
  let
    rootCls = bool "" " list-group-root" . null $ iRoute
    cls = "list-group flex-column" <> rootCls
  divClass cls $
    traverse_ mkMenuSection sections

  dRoute' <- holdUniqDyn dRoute
  tellStorageRemove ExerciseTag . void . updated $ dRoute'

mkMenuSection :: (MonadWidget t m, RouteWriter t RouteFragment m, HasRoute t RouteFragment m, HasStorage t AppTags m)
              => Section m
              -> ReaderT [RouteFragment] m ()
mkMenuSection s = do
  dRoute <- lift allRouteSegments
  iRoute <- ask
  let
    next = _sRoute s : iRoute
    route = reverse next
    dActive = (== route) <$> dRoute
    dParentActive = isPrefixOf route <$> dRoute
    hasChildren = not . null . _sSubSections $ s
    mkAttrs a =
      "href" =: ("#/" <> routeToText route) <>
      "class" =: ("list-group-item list-group-item-action " <> bool "" "active" a)

  elDynAttr "a" (mkAttrs <$> dActive) $ do
    let
      dCaret =
        if hasChildren
        then bool "fa-caret-right" "fa-caret-down" <$> dParentActive
        else ""
    elDynClass "i" ("fa " <> dCaret) blank
    text . _sName $ s

  let
    showChildren False =
      blank
    showChildren True =
      local ((_sRoute s) :) $ mkMenu' . _sSubSections $ s
  void . dyn $ showChildren <$> dParentActive

