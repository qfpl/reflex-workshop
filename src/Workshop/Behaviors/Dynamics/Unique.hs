{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Dynamics.Unique (
    exUnique
  ) where

import Control.Monad (void)

import qualified Data.Text as Text

import Reflex.Dom

import Types.Exercise

import Exercises.Behaviors.Dynamics.Unique
import Solutions.Behaviors.Dynamics.Unique

mkIn :: MonadWidget t m
     => m (Dynamic t (Int, Int), Event t ())
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick
  let
    multiple n =
      (== 0) . (`mod` n)
    downsample n =
      fmap (`div` n) . ffilter (multiple n)
    eIn =
      updated dIn
    eIn1 =
      downsample 2 eIn
    eIn2 =
      downsample 3 eIn

  dIn1 <- holdDyn 0 eIn1
  dIn2 <- holdDyn 0 eIn2

  divClass "row" $ do
    divClass "col-6" $ text "Input 1"
    divClass "col-6" $ display dIn1

  divClass "row" $ do
    divClass "col-6" $ text "Input 2"
    divClass "col-6" $ display dIn2

  pure ((,) <$> dIn1 <*> dIn2, void eTick)

mk :: MonadWidget t m
   => (Dynamic t (Int, Int) -> m (Dynamic t Int, Dynamic t Int))
   -> (Dynamic t (Int, Int), Event t ())
   -> m ()
mk fn (dIn, eTick) = do
  (dMid1, dMid2) <- fn dIn

  let
    collect d =
      holdDyn "" . leftmost $ [
        Text.pack . show <$> updated d
      , "" <$ eTick
      ]

  dOut1 <- collect dMid1
  dOut2 <- collect dMid2

  divClass "row" $ do
    divClass "col-6" $ text "Output 1"
    divClass "col-6" $ dynText dOut1

  divClass "row" $ do
    divClass "col-6" $ text "Output 2"
    divClass "col-6" $ dynText dOut2

exUnique :: MonadWidget t m
          => Exercise m
exUnique =
  let
    problem =
      Problem
        "pages/behaviors/dynamics/unique.html"
        "src/Exercises/Behaviors/Dynamics/Unique.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk uniqueSolution) (mk uniqueExercise)
    solution =
      Solution [
        "pages/behaviors/dynamics/unique/solution/0.html"
      , "pages/behaviors/dynamics/unique/solution/1.html"
      , "pages/behaviors/dynamics/unique/solution/2.html"
      ]
  in
    Exercise
      "unique"
      "unique"
      problem
      progress
      solution
