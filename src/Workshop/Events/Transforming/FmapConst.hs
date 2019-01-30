{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE GADTs #-}
module Workshop.Events.Transforming.FmapConst (
    exFmapConst
  ) where

import qualified Data.Text as Text

import Reflex.Dom.Core

import Types.Exercise
import Util.Bootstrap

import Exercises.Events.Transforming.FmapConst
import Solutions.Events.Transforming.FmapConst

mk :: MonadWidget t m
   => (Event t () -> Event t Int)
   -> (Event t () -> Event t Int)
   -> m ()
mk fn3 fn5 = do
  e3 <- divClass "row" $ do
    divClass "col-5 p-1" $ text "Click for 3"
    divClass "col-5 p-1" $ buttonClass "Click me" "btn"

  e5 <- divClass "row" $ do
    divClass "col-5 p-1" $ text "Click for 5"
    divClass "col-5 p-1" $ buttonClass "Click me" "btn"

  let
    eIn = leftmost [fn3 e3, fn5 e5]
  dOut <- holdDyn "?" $ Text.pack . show <$> eIn

  divClass "row" $
    divClass "col-sm-12" $ dynText dOut

exFmapConst :: forall t m. MonadWidget t m
            => Exercise m
exFmapConst =
  let
    problem =
      Problem
        "pages/events/transforming/fmapConst.html"
        "src/Exercises/Events/Transforming/FmapConst.hs"
        mempty
    progress =
      ProgressNoSetup (mk fmapConstSolution3 fmapConstExercise5) (mk fmapConstExercise3 fmapConstExercise5)
    solution =
      Solution [
        "pages/events/transforming/fmapConst/solution/0.html"
      , "pages/events/transforming/fmapConst/solution/1.html"
      , "pages/events/transforming/fmapConst/solution/2.html"
      , "pages/events/transforming/fmapConst/solution/3.html"
      , "pages/events/transforming/fmapConst/solution/4.html"
      ]
  in
    Exercise
      "fmapConst"
      "fmapConst"
      problem
      progress
      solution
