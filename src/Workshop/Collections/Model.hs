{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.Collections.Model (
    exModel
  ) where

import Control.Lens

import Reflex.Dom.Core

import Types.Exercise

import Common.Todo
import Exercises.Todo.List
import Solutions.Todo.Collections.Model.List

mk :: MonadWidget t m
   => ([TodoItem] -> m (Dynamic t [TodoItem]))
   -> [TodoItem]
   -> m ()
mk fn tis = divClass "row" $ do
  dItems <- divClass "col" $
    fn tis

  let
    dComplete =
      fmap (view todoItem_text) . filter (view todoItem_complete) <$> dItems

  divClass "col" $ do
    el "div" . text $ "Completed items"
    el "ul" . simpleList dComplete $
      el "li" . dynText

  pure ()

exModel :: MonadWidget t m
        => Exercise m
exModel =
  let
    problem =
      Problem
        "pages/collections/model.html"
        "src/Exercises/Todo/List.hs"
        mempty
    progress =
      let tis = [TodoItem False "A", TodoItem True "B", TodoItem False "C"]
      in ProgressNoSetup (mk todoListModelSolution tis) (mk todoListModelExercise tis)
    solution =
      Solution [
        "pages/collections/model/solution/0.html"
      , "pages/collections/model/solution/1.html"
      , "pages/collections/model/solution/2.html"
      , "pages/collections/model/solution/3.html"
      ]
  in
    Exercise
      "model"
      "model"
      problem
      progress
      solution
