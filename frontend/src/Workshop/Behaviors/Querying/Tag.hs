{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeApplications #-}
module Workshop.Behaviors.Querying.Tag (
    exTag
  ) where

import qualified Data.Text as Text

import Reflex.Dom

import Static

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Querying.Tag
import Solutions.Behaviors.Querying.Tag

mkIn :: MonadWidget t m
     => m (Dynamic t Int, Event t ())
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick

  divClass "row" $ do
    divClass "col-5 p-1" $ text "Behavior in"
    divClass "col-5 p-1" $ display dIn

  eClick <- divClass "row" $ do
    divClass "col-5 p-1" $ text "Event in"
    divClass "col-5 p-1" $ buttonClass "Click me" "btn"

  pure (dIn, eClick)

mk :: MonadWidget t m
   => (Behavior t Int -> Event t () -> Event t Int)
   -> (Dynamic t Int, Event t ())
   -> m ()
mk fn (dIn, eClick) = do
  let
    eOut = fn (current dIn) eClick
  dOut <- holdDyn "" $ Text.pack . show <$> eOut

  divClass "row" $ do
    divClass "col-5 p-1" $ text "Event out"
    divClass "col-5 p-1" $ dynText dOut

exTag :: MonadWidget t m
       => Exercise m
exTag =
  let
    problem =
      Problem
        (static @ "pages/behaviors/querying/tag.html")
        "src/Exercises/Behaviors/Querying/Tag.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk tagSolution) (mk tagExercise)
    solution =
      Solution [
        static @ "pages/behaviors/querying/tag/solution/0.html"
      , static @ "pages/behaviors/querying/tag/solution/1.html"
      , static @ "pages/behaviors/querying/tag/solution/2.html"
      , static @ "pages/behaviors/querying/tag/solution/3.html"
      , static @ "pages/behaviors/querying/tag/solution/4.html"
      , static @ "pages/behaviors/querying/tag/solution/5.html"
      , static @ "pages/behaviors/querying/tag/solution/6.html"
      ]
  in
    Exercise
      "tag"
      "tag"
      problem
      progress
      solution
