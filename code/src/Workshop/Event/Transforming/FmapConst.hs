{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Event.Transforming.FmapConst (
    fmapConstProblem
  ) where

import Control.Lens

import qualified Data.Text as Text

import Reflex
import Reflex.Dom.Core

import Util.Bootstrap
import Util.Exercises
import Util.File
import Util.Section

import Workshop.Event.Transforming.FmapConst.Exercise
import Workshop.Event.Transforming.FmapConst.Solution

mk :: MonadWidget t m
   => (Event t () -> Event t Int)
   -> (Event t () -> Event t Int)
   -> Event t ()
   -> Event t ()
   -> m (Event t (), Event t ())
mk fn3 fn5 e3In e5In =
  card $ do
    e3Out <- divClass "row" $ do
      divClass "col-5 p-1" $ text "Click for 3"
      divClass "col-5 p-1" $ buttonClass "Click me" "btn"

    e5Out <- divClass "row" $ do
      divClass "col-5 p-1" $ text "Click for 5"
      divClass "col-5 p-1" $ buttonClass "Click me" "btn"

    let
      e3 = leftmost [e3In, e3Out]
      e5 = leftmost [e5In, e5Out]
      eIn = leftmost [fn3 e3, fn5 e5]
    dOut <- holdDyn "?" $ Text.pack . show <$> eIn

    divClass "row" $
      divClass "col-sm-12" $ dynText dOut

    pure (e3Out, e5Out)

fmapConstProblem :: MonadWidget t m => m (Problem t m)
fmapConstProblem =
  pure $ Problem fmapConstGoal fmapConstEx "../pages/events/transforming/fmapConst/solution.md"

fmapConstGoal :: MonadWidget t m => m ()
fmapConstGoal =
  loadMarkdown "../pages/events/transforming/fmapConst/goal.md"

fmapConstEx :: MonadWidget t m => m ()
fmapConstEx = mdo
  [a, b, c] <- loadMarkdownSingle "../pages/events/transforming/fmapConst/exercise.md"
  a
  (e3Ex, e5Ex) <- mk fmapConstExercise3 fmapConstExercise5 e3Sol e5Sol
  b
  (e3Sol, e5Sol) <- mk fmapConstSolution3 fmapConstSolution5 e3Ex e5Ex
  c

