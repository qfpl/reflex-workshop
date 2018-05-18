{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Behavior.Querying.Tag (
    tagProblem
  ) where

import Control.Lens

import Control.Monad.Trans (liftIO)
import Data.Time.Clock

import qualified Data.Text as Text

import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File

import Workshop.Behavior.Querying.Tag.Exercise
import Workshop.Behavior.Querying.Tag.Solution

mk :: MonadWidget t m
   => (Behavior t Int -> Event t () -> Event t Int)
   -> Dynamic t Int
   -> Event t ()
   -> m (Event t ())
mk fn dIn eClickIn = card $ do

  divClass "row" $ do
    divClass "col-5 p-1" $ text "Behavior in"
    divClass "col-5 p-1" $ display dIn

  eClickOut <- divClass "row" $ do
    divClass "col-5 p-1" $ text "Event in"
    divClass "col-5 p-1" $ buttonClass "Click me" "btn"

  let
    eClick = leftmost [eClickIn, eClickOut]
    eOut = fn (current dIn) eClick
  dOut <- holdDyn "" $ Text.pack . show <$> eOut

  divClass "row" $ do
    divClass "col-5 p-1" $ text "Event out"
    divClass "col-5 p-1" $ dynText dOut

  pure eClickOut

tagProblem :: MonadWidget t m => m (Problem t m)
tagProblem =
  pure $ Problem tagGoal tagEx "../pages/behaviors/querying/tag/solution.md"

tagGoal :: MonadWidget t m => m ()
tagGoal =
  loadMarkdown "../pages/behaviors/querying/tag/goal.md"

tagEx :: MonadWidget t m => m ()
tagEx = mdo
  time <- liftIO getCurrentTime
  eTick <- tickLossy 1 time

  dIn <- count eTick

  [a, b, c] <- loadMarkdownSingle "../pages/behaviors/querying/tag/exercise.md"
  a
  eEx <- mk tagExercise dIn eSol
  b
  eSol <- mk tagSolution dIn eEx
  c

  pure ()

