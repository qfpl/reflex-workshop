{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Event.Filtering.FmapMaybe (
    fmapMaybeProblem
  ) where

import Control.Lens

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex
import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Event.Filtering.FmapMaybe.Exercise
import Workshop.Event.Filtering.FmapMaybe.Solution

mk :: MonadWidget t m
   => (Event t Text -> (Event t Text, Event t Int))
   -> Event t Text
   -> m (Event t Text)
mk fn eChangeIn = card $ do
  (dIn, eChangeOut) <- divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ do
      ti <- textInput $ def & textInputConfig_setValue .~ eChangeIn
      pure (ti ^. textInput_value, ti ^. textInput_input)

  let
    eIn = updated dIn
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

  pure eChangeOut

fmapMaybeProblem :: MonadWidget t m => m (Problem t m)
fmapMaybeProblem = 
  pure $ Problem fmapMaybeGoal fmapMaybeEx "../pages/events/filtering/fmapMaybe/solution.md"

fmapMaybeGoal :: MonadWidget t m => m ()
fmapMaybeGoal =
  loadMarkdown "../pages/events/filtering/fmapMaybe/goal.md"

fmapMaybeEx :: MonadWidget t m => m ()
fmapMaybeEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/events/filtering/fmapMaybe/exercise.md"
  a
  eExercise <- mk fmapMaybeExercise eSolution
  b
  eSolution <- mk fmapMaybeSolution eExercise
  c

