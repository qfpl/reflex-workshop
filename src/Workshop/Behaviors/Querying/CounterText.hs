{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Querying.CounterText (
    exCounterText
  ) where

import Data.Text (Text)

import Reflex.Dom

import Types.Exercise
import Util.Bootstrap

import Exercises.Behaviors.Querying.CounterText
import Solutions.Behaviors.Querying.CounterText

mkIn :: MonadWidget t m
     => m (Behavior t Text, Event t (), Event t ())
mkIn = do
  dText <- divClass "row" $ do
    divClass "col-5 m-2" $ text "Input"
    divClass "col-5 m-2" $ do
      ti <- textInput $ def
      pure $ value ti

  (eAdd, eClear) <- divClass "row" $ do
    eA <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
    eC <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
    pure (eA, eC)

  pure (current dText, eAdd, eClear)

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Text -> Event t () -> Event t () -> (Event t Text, Event t Int))
   -> (Behavior t Text, Event t (), Event t ())
   -> m ()
mk fn (bText, eAdd, eClear) = mdo
  let
    (eError, eOut) = fn (current dOut) bText eAdd eClear

  dError <- holdDyn "" . leftmost $ [eError, "" <$ eOut]
  dOut <- holdDyn 0 eOut

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Error"
    divClass "col-5 m-2" $ dynText dError
  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dOut

exCounterText :: MonadWidget t m
              => Exercise m
exCounterText =
  let
    problem =
      Problem
      "pages/behaviors/querying/counterText.html"
      "src/Exercises/Behaviors/Querying/CounterText.hs"
      mempty
    progress =
      ProgressSetup True mkIn (mk counterTextSolution) (mk counterTextExercise)
    solution =
      Solution [
        "pages/behaviors/querying/counterText/solution/0.html"
      , "pages/behaviors/querying/counterText/solution/1.html"
      , "pages/behaviors/querying/counterText/solution/2.html"
      ]
  in
    Exercise
      "counterText"
      "counterText"
      problem
      progress
      solution
