{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Querying.CounterText (
    counterTextProblem
  ) where

import Control.Lens

import Control.Monad.Trans (liftIO)

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Event.Filtering.FmapMaybe.Exercise
import Workshop.Event.Filtering.FmapMaybe.Solution

import Workshop.Behavior.Querying.CounterText.Exercise
import Workshop.Behavior.Querying.CounterText.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Behavior t Text -> Event t () -> Event t () -> (Event t Text, Event t Int))
   -> Event t Text
   -> Event t ()
   -> Event t ()
   -> m (Event t Text, Event t (), Event t ())
mk fn eTextIn eAddIn eClearIn = card $ mdo
  (dText, eTextOut) <- divClass "row" $ do
    divClass "col-5 m-2" $ text "Input"
    divClass "col-5 m-2" $ do
      ti <- textInput $ def & textInputConfig_setValue .~ eTextIn
      pure (ti ^. textInput_value, ti ^. textInput_input)
  (eAddOut, eClearOut) <- divClass "row" $ do
    eA <- divClass "col-5 m-2" $ buttonClass "Add" "btn btn-block"
    eC <- divClass "col-5 m-2" $ buttonClass "Clear" "btn btn-block"
    pure (eA, eC)

  let
    eAdd = leftmost [eAddIn, eAddOut]
    eClear = leftmost [eClearIn, eClearOut]
    (eError, eOut) = fn (current dOut) (current dText) eAdd eClear

  dError <- holdDyn "" . leftmost $ [eError, "" <$ eOut]
  dOut <- holdDyn 0 eOut

  divClass "row" $ do
    divClass "col-5 m-2" $ text "Error"
    divClass "col-5 m-2" $ dynText dError
  divClass "row" $ do
    divClass "col-5 m-2" $ text "Count"
    divClass "col-5 m-2" $ display dOut

  pure (eTextOut, eAddOut, eClearOut)

counterTextProblem :: MonadWidget t m => m (Problem t m)
counterTextProblem = 
  pure $ Problem counterTextGoal counterTextEx "../pages/behaviors/querying/counterText/solution.md"

counterTextGoal :: MonadWidget t m => m ()
counterTextGoal =
  loadMarkdown "../pages/behaviors/querying/counterText/goal.md"

counterTextEx :: MonadWidget t m => m ()
counterTextEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/querying/counterText/exercise.md"
  a
  (eTextEx, eAddEx, eClearEx)    <- mk counterTextExercise eTextSol eAddSol eClearSol
  b
  (eTextSol, eAddSol, eClearSol) <- mk counterTextSolution eTextEx eAddEx eClearEx
  c

