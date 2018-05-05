{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE TupleSections #-}
module Workshop (
    main
  ) where

import Control.Monad (void)
import Data.Bool (bool)
import Data.Monoid ((<>))

import Control.Lens

import Data.Text (Text)

import qualified Data.Map as Map

import Reflex
import Reflex.Dom.Core

import Util.Run
import Util.Log.Client
import Util.Section

main :: IO ()
main =
  run 9090 $ divClass "container-fluid" $ do
    mkMainPanel [
        Section "Section 1" [
          SubSection "SubSection 1" $ 
            el "div" $ text "a"
        , SubSection "SubSection 2" $ 
            el "div" $ text "b"
        ]
        , Section "Section 2" [
          SubSection "SubSection 1" $ 
            el "div" $ text "c"
        , SubSection "SubSection 2" $ 
            el "div" $ text "d"
        ]
      ]

    pure ()

mkMainPanel :: MonadWidget t m => [Section m] -> m ()
mkMainPanel sections = divClass "container-fluid" $ mdo
  ePostBuild <- getPostBuild
  (_, eInitial) <- fetch ePostBuild

  dIndices <- holdDyn (0, 0) .
              leftmost $ [
                  eInitial
                , eMenu
                ]

  (_, _) <- update dIndices .
            void .
            updated $
            dIndices

  let
    mkTitle (x, _) =
      sectionName .
      (!! x) $
      sections
    mkSubtitle (x, y) =
      subSectionName .
      (!! y) .
      sectionSubsections .
      (!! x) $
      sections
  divClass "row" . divClass "container-fluid" $ do
    mkNav (mkTitle <$> dIndices) (mkSubtitle <$> dIndices)

  eMenu <- divClass "row" . divClass "container-fluid d-flex flex-row"$ do
    eMenu' <- mkMenu dIndices sections
    mkMain dIndices sections
    pure eMenu'

  pure ()

mkNav :: MonadWidget t m
      => Dynamic t Text
      -> Dynamic t Text
      -> m ()
mkNav dTitle dSubTitle =
  elClass "nav" "navbar navbar-expand navbar-light bg-light" $ do
    void $ linkClass "Reflex Workshop" "navbar-brand"
    elClass "nav" "nav nav-pills" $ do
      elClass "a" "nav-link" $
        dynText dTitle
      elClass "a" "nav-link" $
        dynText dSubTitle

    pure ()

mkMenu :: MonadWidget t m
       => Dynamic t (Int, Int)
       -> [Section m]
       -> m (Event t (Int, Int))
mkMenu dIndices sections =
  elClass "nav" "nav nav-pills navbar-light bg-light flex-column justify-content-start" $ do
    xs <- traverse (uncurry $ mkMenuSection dIndices) .
          zip [0..] $
          sections
    pure $ leftmost xs

mkMenuSection :: MonadWidget t m
              => Dynamic t (Int, Int)
              -> Int
              -> Section m
              -> m (Event t (Int, Int))
mkMenuSection dIndices index section = do
  let
    dActive = ((== index) . fst) <$> dIndices
    mkAttrs a =
      "href" =: "#" <>
      "class" =: ("nav-link " <> bool "" "active" a)
  (e, _) <- elDynAttr' "a" (mkAttrs <$> dActive) .
            text .
            sectionName $
            section
  let
    eSection = (index, 0) <$ domEvent Click e

  let
    sub False = pure never
    sub True = do
      elClass "nav" "nav nav-pills flex-column justify-content-start" $ do
        xs <- traverse (uncurry $ mkMenuSubSection dIndices index) .
              zip [0..] $
              sectionSubsections $
              section
        pure $ leftmost xs
  de <- widgetHold (pure never) .
        fmap sub .
        updated $
        dActive
  let
    eSubSection = switchDyn de
  pure $ leftmost [eSection, eSubSection]

mkMenuSubSection :: MonadWidget t m
                 => Dynamic t (Int, Int)
                 -> Int
                 -> Int
                 -> SubSection m
                 -> m (Event t (Int, Int))
mkMenuSubSection dIndices index1 index2 subSection = do
  let
    dActive = ((== index2) . snd) <$> dIndices
    mkAttrs a =
      "href" =: "#" <>
      "class" =: ("nav-link ml-3 my-1 " <> bool "" "active" a)
  (e, _) <- elDynAttr' "a" (mkAttrs <$> dActive) .
            text .
            subSectionName $
            subSection
  pure $ (index1, index2) <$ domEvent Click e

mkMain :: MonadWidget t m
       => Dynamic t (Int, Int)
       -> [Section m]
       -> m ()
mkMain dIndices sections =
  let
    mkWidget (x, y) =
      subSectionContent .
      (!! y) .
      sectionSubsections .
      (!! x) $
      sections
  in
    divClass "container-fluid" .
    void .
    widgetHold blank .
    fmap mkWidget .
    updated $
    dIndices
