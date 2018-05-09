{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Util.UI (
    mkMainPanel
  ) where

import Control.Monad (void)
import Data.Bool (bool)
import Data.Maybe (fromMaybe)
import Data.Monoid ((<>))

import Control.Lens

import Data.Text (Text)

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Util.Log.Client
import Util.Section
import Util.WorkshopState

mkMainPanel :: MonadWidget t m => [Section t m] -> m ()
mkMainPanel sections = divClass "container-fluid" $ mdo
  ePostBuild <- getPostBuild
  (_, eInitial) <- fetch ePostBuild

  dState <- foldDyn ($) initialWorkshopState .
            mergeWith (.) $ [
              const <$> eInitial
            , eChange
            ]

  (_, _) <- update dState .
            void .
            updated $
            dState

  dIndex <- holdUniqDyn $ _wsIndex <$> dState
  dExercises <- holdUniqDyn $ _wsExercises <$> dState

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
  divClass "row" . divClass "container-fluid" $
    mkNav (mkTitle <$> dIndex) (mkSubtitle <$> dIndex)

  eChange <- divClass "row" . divClass "container-fluid d-flex flex-row"$ do
    eMenu <- mkMenu dIndex sections
    eMain <- mkMain dIndex dExercises sections
    pure $ mergeWith (.) [eMenu, eMain]

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
       -> [Section t m]
       -> m (Event t (WorkshopState -> WorkshopState))
mkMenu dIndex sections =
  elClass "nav" "nav nav-pills navbar-light bg-light flex-column justify-content-start" $ do
    xs <- traverse (uncurry $ mkMenuSection dIndex) .
          zip [0..] $
          sections
    pure $ mergeWith (.) xs

mkMenuSection :: MonadWidget t m
              => Dynamic t (Int, Int)
              -> Int
              -> Section t m
              -> m (Event t (WorkshopState -> WorkshopState))
mkMenuSection dIndex index section = do
  let
    dActive = (== index) . view _1 <$> dIndex
    mkAttrs a =
      "href" =: "#" <>
      "class" =: ("nav-link " <> bool "" "active" a)
  (e, _) <- elDynAttr' "a" (mkAttrs <$> dActive) .
            text .
            sectionName $
            section
  let
    eSection = set wsIndex (index, 0) <$ domEvent Click e

  let
    sub False = pure never
    sub True =
      elClass "nav" "nav nav-pills flex-column justify-content-start" $ do
        xs <- traverse (uncurry $ mkMenuSubSection dIndex index) .
              zip [0..] .
              sectionSubsections $
              section
        pure $ mergeWith (.) xs
  active <- sample . current $ dActive
  de <- widgetHold (sub active) .
        fmap sub .
        updated $
        dActive
  let
    eSubSection = switchDyn de
  pure $ mergeWith (.) [eSection, eSubSection]

mkMenuSubSection :: MonadWidget t m
                 => Dynamic t (Int, Int)
                 -> Int
                 -> Int
                 -> SubSection t m
                 -> m (Event t (WorkshopState -> WorkshopState))
mkMenuSubSection dIndex index1 index2 subSection = do
  let
    dActive = (== index2) . view _2 <$> dIndex
    mkAttrs a =
      "href" =: "#" <>
      "class" =: ("nav-link ml-3 my-1 " <> bool "" "active" a)
  (e, _) <- elDynAttr' "a" (mkAttrs <$> dActive) .
            text .
            subSectionName $
            subSection
  pure $ set wsIndex (index1, index2) <$ domEvent Click e

mkMain :: MonadWidget t m
       => Dynamic t (Int, Int)
       -> Dynamic t (Map (Int, Int) ExerciseState)
       -> [Section t m]
       -> m (Event t (WorkshopState -> WorkshopState))
mkMain dIndex dExercises sections =
  let
    mkWidget (x, y) = do
      let
        fn = subSectionContent .
             (!! y) .
             sectionSubsections .
             (!! x) $
             sections
        arg = fromMaybe initialExerciseState .
              Map.lookup (x, y) <$>
              dExercises
      e <- fn arg
      pure $ (\is v ws -> ws & wsExercises .~ Map.insert (x, y) v is) <$> current dExercises <@> e
  in do
    index <- sample . current $ dIndex
    divClass "container-fluid" .
      fmap switchDyn .
      widgetHold (mkWidget index) .
      fmap mkWidget .
      updated $
      dIndex
