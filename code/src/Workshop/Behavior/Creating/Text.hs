{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Creating.Text (
    textProblem
  ) where

import Control.Monad.Trans (liftIO)

import Control.Lens

import Data.Text (Text)

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Creating.Text.Exercise
import Workshop.Behavior.Creating.Text.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Event t Text -> m (Behavior t [Text], Event t [Text]))
   -> Event t Text
   -> m (Event t Text)
mk fn eIn = card $ mdo

  eOut <- divClass "row" $ do
    divClass "col-6" $ text "Input"
    divClass "col-6" $ do
      ti <- textInput $ def & textInputConfig_setValue .~ eIn
      pure $ ti ^. textInput_input


  let
    sawtooth n x =
      let
        y = x `mod` (2 * n)
      in
        if y < n then y else 2 * n - y
    bSize = (+ 3) . sawtooth 4 <$> current dCount
    e = leftmost [eOut, eIn]

  (bs, es) <- fn bSize e
  let
    d = unsafeDynamic bs es

  dCount <- count e

  _ <- simpleList d $ \dt ->
    divClass "row" $ do
      divClass "col-6" $ text "Output"
      divClass "col-6" $ dynText dt

  pure eOut

textProblem :: MonadWidget t m => m (Problem t m)
textProblem =
  pure $ Problem textGoal textEx "../pages/behaviors/creating/text/solution.md"

textGoal :: MonadWidget t m => m ()
textGoal =
  loadMarkdown "../pages/behaviors/creating/text/goal.md"

textEx :: MonadWidget t m => m ()
textEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/creating/text/exercise.md"
  a
  eEx <- mk textExercise eSol
  b
  eSol <- mk textSolution eEx
  c
