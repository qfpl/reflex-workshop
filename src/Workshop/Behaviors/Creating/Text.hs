{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Workshop.Behaviors.Creating.Text (
    exText
  ) where

import Control.Monad (void)

import Data.Text (Text)

import Control.Lens

import Reflex.Dom

import Types.Exercise

import Exercises.Behaviors.Creating.Text
import Solutions.Behaviors.Creating.Text

mkIn :: MonadWidget t m
     => m (Event t Text)
mkIn = divClass "row" $ do
  divClass "col-6" $ text "Input"
  divClass "col-6" $ do
    ti <- textInput def
    pure $ ti ^. textInput_input

mk :: MonadWidget t m
   => (Behavior t Int -> Event t Text -> m (Behavior t [Text], Event t [Text]))
   -> Event t Text
   -> m ()
mk fn eIn = do
  dCount <- count eIn

  let
    sawtooth n x =
      let
        y = x `mod` (2 * n)
      in
        if y < n then y else 2 * n - y
    bSize = (+ 3) . sawtooth 4 <$> current dCount

  (bs, es) <- fn bSize eIn
  let
    d = unsafeDynamic bs es

  void . simpleList d $ \dt ->
    divClass "row" $ do
      divClass "col-6" $ text "Output"
      divClass "col-6" $ dynText dt

exText :: MonadWidget t m
        => Exercise m
exText =
  let
    problem =
      Problem
        "pages/behaviors/creating/text.html"
        "src/Exercises/Behaviors/Creating/Text.hs"
        mempty
    progress =
      ProgressSetup True mkIn (mk textSolution) (mk textExercise)
    solution =
      Solution [
        "pages/behaviors/creating/text/solution/0.html"
      , "pages/behaviors/creating/text/solution/1.html"
      , "pages/behaviors/creating/text/solution/2.html"
      , "pages/behaviors/creating/text/solution/3.html"
      ]
  in
    Exercise
      "text"
      "text"
      problem
      progress
      solution
