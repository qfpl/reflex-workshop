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
{-# LANGUAGE RecursiveDo #-}
module UI.Menu (
    mkMenu
  ) where

import Control.Monad (void, forM)
import Data.Bool (bool)
import Data.Maybe (isNothing)
import Data.Semigroup ((<>))

import Control.Error (headMay)

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
      elClass "ul" "navbar-nav" $ mdo

        dRoute <- allRouteSegments

        let attrs =
              "class" =: "nav-link btn dropdown-toggle" <>
              "aria-haspopup" =: "true" <>
              "aria-expanded" =: "false"

        let
          findSection (h:_) = headMay . filter ((== h) . _sRoute)
          findSection _ = headMay

          dSection = findSection <$> dRoute <*> pure sections

          findSubSection (_:h:_) (Just s) = headMay . filter ((== h) . _sRoute) . _sSubSections $ s
          findSubSection _ _ = Nothing

          dSubSection = findSubSection <$> dRoute <*> dSection

        dShowSection <- elClass "li" "nav-item active dropdown" $ mdo
          (elShow, _) <- elAttr' "a" attrs $
            dynText $ maybe "Whoops!" _sName <$> dSection
          let eShow = domEvent Click elShow
          dChangeShow <- toggle False eShow
          dShow <- holdDyn False . leftmost $
            [ updated dChangeShow
            , False <$ eHide
            , False <$ (ffilter id . updated $ dShowSubSection)
            ]
          let
            dmClass = ("dropdown-menu" <>) . bool "" " show" <$> dShow

          eHides <- elDynClass "div" dmClass $
            forM sections $ \s ->
              let
                href =
                  ("#/" <>) . routeToText . pure . _sRoute $ s
                dActive =
                  bool "" " active" . maybe False ((== _sRoute s) . _sRoute) <$> dSection
                dAttr = pure ("href" =: href) <>
                       ("class" =:) . ("dropdown-item" <>) <$> dActive
              in do
                (elHide, _) <- elDynAttr' "a" dAttr $
                  text $ _sName s
                pure $ domEvent Click elHide

          let eHide = leftmost eHides

          pure dChangeShow

        dShowSubSection <- elClass "li" "nav-item active dropdown" $ mdo
          (elShow, _) <- elAttr' "a" attrs $
            dynText $ maybe "Introduction" _sName <$> dSubSection
          let eShow = domEvent Click elShow
          dChangeShow <- toggle False eShow
          dShow <- holdDyn False . leftmost $
            [ updated dChangeShow
            , False <$ eHide
            , False <$ (ffilter id . updated $ dShowSection)
            ]
          let
            dmClass = ("dropdown-menu" <>) . bool "" " show" <$> dShow

          eHide <- elDynClass "div" dmClass $ do
            let
              dIntroHref = ("href" =:) . maybe "" (("#/" <>) . routeToText . pure . _sRoute) <$> dSection
              dIntroActive = bool "" " active" . isNothing <$> dSubSection
              dIntroClass = ("class" =:) . ("dropdown-item" <>) <$> dIntroActive
            elDynAttr "a" (dIntroHref <> dIntroClass) $
              text "Introduction"

            de <- simpleList (maybe [] _sSubSections <$> dSection) $ \ds ->
              let
                r = routeToText . pure . _sRoute
                dHref = ("href" =:) <$> mconcat [pure "#/", maybe "" r <$> dSection, pure "/" , r <$> ds]
                dActive = (\s1 -> bool "" " active" . maybe False ((== _sRoute s1) . _sRoute)) <$> ds <*> dSubSection
                diClass = ("class" =:) . ("dropdown-item" <>) <$> dActive
              in do
                (elHide, _) <- elDynAttr' "a" (diClass <> dHref) $
                  dynText $ _sName <$> ds
                pure $ domEvent Click elHide
            pure . switchDyn . fmap leftmost $ de

          pure dChangeShow

        dRoute' <- holdUniqDyn dRoute
        tellStorageRemove ExerciseTag . void . updated $ dRoute'
