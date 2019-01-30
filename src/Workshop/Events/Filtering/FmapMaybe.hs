{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Events.Filtering.FmapMaybe (
    exFmapMaybe
  ) where

import Data.Text (Text)
import qualified Data.Text as Text

import Control.Lens

import Reflex.Dom.Core

import Types.Exercise

import Exercises.Events.Filtering.FmapMaybe
import Solutions.Events.Filtering.FmapMaybe

mkIn :: MonadWidget t m
     => m (Event t Text)
mkIn = divClass "row" $ do
  divClass "col-6" $
    text "Input"
  divClass "col-6" $ do
    ti <- textInput $ def
    pure $ ti ^. textInput_input

mk :: MonadWidget t m
   => (Event t Text -> (Event t Text, Event t Int))
   -> Event t Text
   -> m ()
mk fn eIn = do
  let
    (eError, eOut) = fn . ffilter (not . Text.null) $ eIn

  dError <- holdDyn "" . leftmost $ [
      eError
    , "" <$ eIn
    ]

  dOut <- holdDyn "" . leftmost $ [
      Text.pack . show <$> eOut
    , "" <$ eIn
    ]

  divClass "row" $ do
    divClass "col-6" $ text "Error"
    divClass "col-6" $ dynText dError

  divClass "row" $ do
    divClass "col-6" $ text "Output"
    divClass "col-6" $ dynText dOut

exFmapMaybe :: MonadWidget t m
            => Exercise m
exFmapMaybe =
  let
    problem =
      Problem
        "pages/events/filtering/fmapMaybe.html"
        "src/Exercises/Events/Filtering/FmapMaybe.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk fmapMaybeSolution) (mk fmapMaybeExercise)
    solution =
      Solution [
        "pages/events/filtering/fmapMaybe/solution/0.html"
      , "pages/events/filtering/fmapMaybe/solution/1.html"
      , "pages/events/filtering/fmapMaybe/solution/2.html"
      , "pages/events/filtering/fmapMaybe/solution/3.html"
      , "pages/events/filtering/fmapMaybe/solution/4.html"
      , "pages/events/filtering/fmapMaybe/solution/5.html"
      , "pages/events/filtering/fmapMaybe/solution/6.html"
      , "pages/events/filtering/fmapMaybe/solution/7.html"
      , "pages/events/filtering/fmapMaybe/solution/8.html"
      , "pages/events/filtering/fmapMaybe/solution/9.html"
      , "pages/events/filtering/fmapMaybe/solution/10.html"
      , "pages/events/filtering/fmapMaybe/solution/11.html"
      , "pages/events/filtering/fmapMaybe/solution/12.html"
      , "pages/events/filtering/fmapMaybe/solution/13.html"
      , "pages/events/filtering/fmapMaybe/solution/14.html"
      ]
  in
    Exercise
      "fmapMaybe"
      "fmapMaybe"
      problem
      progress
      solution
