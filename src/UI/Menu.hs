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

import Control.Monad (void, forM_)
import Data.Bool (bool)
import Data.Foldable (traverse_)
import Data.List (isPrefixOf)
import Data.Maybe (isNothing)
import Data.Semigroup ((<>))

import Control.Error (headMay)

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
mkMenu sections =
  elClass "nav" "navbar navbar-expand navbar-light bg-light" $ do
    void $ linkClass "Reflex Workshop" "navbar-brand"
    let navbarToggleAttrs =
          "class" =: "navbar-toggler" <>
          "type" =: "button" <>
          "data-toggle" =: "collapse" <>
          "data-target" =: "#navDropdown" <>
          "aria-controls" =: "navDropdown" <>
          "aria-expanded" =: "false" <>
          "aria-label" =: "Toggle navigation"
    elAttr "button" navbarToggleAttrs . elClass "span" "navbar-toggler-icon" $ blank
    elAttr "div" ("id" =: "navDropdown" <> "class" =: "collapse navbar-collapse") .
      elClass "ul" "navbar-nav" $ do

        let attrs i =
              "id" =: i <>
              "href" =: "" <>
              "target" =: "_self" <>
              "class" =: "nav-link dropdown-toggle" <>
              "data-toggle" =: "dropdown" <>
              "aria-haspopup" =: "true" <>
              "aria-expanded" =: "false"
        dRoute <- allRouteSegments

        let
          findSection (h:_) = headMay . filter ((== h) . _sRoute)
          findSection _ = headMay

          dSection = findSection <$> dRoute <*> pure sections

          findSubSection (_:h:_) (Just s) = headMay . filter ((== h) . _sRoute) . _sSubSections $ s
          findSubSection _ _ = Nothing

          dSubSection = findSubSection <$> dRoute <*> dSection

        elClass "li" "nav-item active dropdown" $ do
          elAttr "a" (attrs "section-link") $
            dynText $ maybe "Whoops!" _sName <$> dSection

          elAttr "div" ("class" =: "dropdown-menu" <> "aria-labelledby" =: "section-link") .
            forM_ sections $ \s ->
              let
                href =
                  ("#/" <>) . routeToText . pure . _sRoute $ s
                dActive =
                  bool "" " active" . maybe False ((== _sRoute s) . _sRoute) <$> dSection
                dAttr = pure ("href" =: href) <>
                       ("class" =:) . ("dropdown-item" <>) <$> dActive
              in
                elDynAttr "a" dAttr $
                  text $ _sName s

        elClass "li" "nav-item active dropdown" $ do
          elAttr "a" (attrs "subsection-link") $
            dynText $ maybe "Introduction" _sName <$> dSubSection

          elAttr "div" ("class" =: "dropdown-menu" <> "aria-labelledBy" =: "subsection-link") $ do
            let
              dIntroHref = ("href" =:) . maybe "" (("#/" <>) . routeToText . pure . _sRoute) <$> dSection
              dIntroActive = bool "" " active" . isNothing <$> dSubSection
              dIntroClass = ("class" =:) . ("dropdown-item" <>) <$> dIntroActive
            elDynAttr "a" (dIntroHref <> dIntroClass) $
              text "Introduction"

            void . simpleList (maybe [] _sSubSections <$> dSection) $ \ds ->
              let
                r = routeToText . pure . _sRoute
                dHref = ("href" =:) <$> mconcat [pure "#/", maybe "" r <$> dSection, pure "/" , r <$> ds]
                dActive = (\s1 -> bool "" " active" . maybe False ((== _sRoute s1) . _sRoute)) <$> ds <*> dSubSection
                dClass = ("class" =:) . ("dropdown-item" <>) <$> dActive
              in
                elDynAttr "a" (dClass <> dHref) $
                  dynText $ _sName <$> ds

        dRoute' <- holdUniqDyn dRoute
        tellStorageRemove ExerciseTag . void . updated $ dRoute'
