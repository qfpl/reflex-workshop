{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Events.Combining.Leftmost (
    exLeftmost
  ) where

import Data.Text (Text)

import Reflex.Dom.Core

import Types.Exercise

import Exercises.Events.Combining.Leftmost
import Solutions.Events.Combining.Leftmost

mkIn :: MonadWidget t m
     => m (Event t Int)
mkIn = do
  eTick <- tickLossyFromPostBuildTime 1
  dIn <- count eTick

  divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ display dIn

  pure $ updated dIn

mk :: MonadWidget t m
   => (Event t Int -> (Event t Text, Event t Text, Event t Text, Event t Text))
   -> Event t Int
   -> m ()
mk fn eIn = do

  let
    (eFizz, eBuzz, eFizzBuzz, eSolution) = fn eIn

  dFizz <- holdDyn "" . leftmost $ [eFizz, "" <$ eIn]
  divClass "row" $ do
    divClass "col-6" $ text "Fizz"
    divClass "col-6" $ dynText dFizz

  dBuzz <- holdDyn "" . leftmost $ [eBuzz, "" <$ eIn]
  divClass "row" $ do
    divClass "col-6" $ text "Buzz"
    divClass "col-6" $ dynText dBuzz

  dFizzBuzz <- holdDyn "" . leftmost $ [eFizzBuzz, "" <$ eIn]
  divClass "row" $ do
    divClass "col-6" $ text "FizzBuzz"
    divClass "col-6" $ dynText dFizzBuzz

  dSolution <- holdDyn "" . leftmost $ [eSolution, "" <$ eIn]
  divClass "row" $ do
    divClass "col-6" $ text "Solution"
    divClass "col-6" $ dynText dSolution

exLeftmost :: MonadWidget t m
           => Exercise m
exLeftmost =
  let
    problem =
      Problem
        "pages/events/combining/leftmost.html"
        "src/Exercises/Events/Combining/Leftmost.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk leftmostSolution) (mk leftmostExercise)
    solution =
      Solution [
        "pages/events/combining/leftmost/solution/0.html"
      , "pages/events/combining/leftmost/solution/1.html"
      , "pages/events/combining/leftmost/solution/2.html"
      , "pages/events/combining/leftmost/solution/3.html"
      , "pages/events/combining/leftmost/solution/4.html"
      , "pages/events/combining/leftmost/solution/5.html"
      , "pages/events/combining/leftmost/solution/6.html"
      ]
  in
    Exercise
      "leftmost"
      "leftmost"
      problem
      progress
      solution
