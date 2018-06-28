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
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behaviors.Querying.Limit (
    exLimit
  ) where

import qualified Data.Text as Text

import Reflex.Dom

import Static

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Querying.Limit
import Solutions.Behaviors.Querying.Limit

mkIn :: MonadWidget t m
     => m (Event t (), Event t ())
mkIn = divClass "row" $ do
  eAdd <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
  eClear <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
  pure (eAdd, eClear)

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Int -> Event t () -> Event t () -> Event t Int)
   -> (Event t (), Event t ())
   -> m ()
mk fn (eAdd, eClear) = mdo
  dCount <- holdDyn 0 $ fn (current dCount) (current dLimit) eAdd eClear

  let
    defaultLimit = 5

  bLimitIncrease <- hold False . leftmost $ [
      False <$ eClear
    , (==) <$> current dCount <*> current dLimit <@ eAdd
    ]
  bLastClear <- hold False . leftmost $ [
      True <$ eClear
    , False <$ eAdd
    ]

  dLimit <- foldDyn ($) defaultLimit . mergeWith (.) $
    [ (+1) <$ gate bLimitIncrease eClear
    , const defaultLimit <$ gate bLastClear eClear
    ]

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dCount

exLimit :: MonadWidget t m
        => Exercise m
exLimit =
  let
    problem =
      Problem
        (static @ "pages/behaviors/querying/limit.html")
        "src/Exercises/Behaviors/Querying/Limit.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk limitSolution) (mk limitExercise)
    solution =
      Solution [
        static @ "pages/behaviors/querying/limit/solution/0.html"
      , static @ "pages/behaviors/querying/limit/solution/1.html"
      , static @ "pages/behaviors/querying/limit/solution/2.html"
      , static @ "pages/behaviors/querying/limit/solution/3.html"
      ]
  in
    Exercise
      "limit"
      "limit"
      problem
      progress
      solution
