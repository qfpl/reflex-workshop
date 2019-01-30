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
module Solutions.Todo.Collections.Model.List where

import Control.Lens

import qualified Data.Text as Text

import qualified Data.Map as Map

import Reflex.Dom.Core

import Common.Todo
import Solutions.Todo.Collections.Model.Item

addItem :: MonadWidget t m
        => m (Event t TodoItem)
addItem = mdo
  ti <- textInput $
    def & setValue .~ ("" <$ eEnter)

  let
    eEnter    = keypress Enter ti
    bText     = current $ value ti
    eStripped = Text.strip <$> bText <@ eEnter
    eText     = ffilter (not . Text.null) eStripped
    eAdd      = TodoItem False <$> eText

  pure eAdd

todoListModelSolution :: MonadWidget t m
                      => [TodoItem]
                      -> m (Dynamic t [TodoItem])
todoListModelSolution items = mdo
  eItem <- addItem
  eAdd  <- numberOccurrencesFrom (length items) eItem
  let
    eInsert = (\(k,v) -> k =: Just v) <$> eAdd
    m = Map.fromList . zip [0..] $ items
  dmes <- listHoldWithKey m eListChange $ \_ item -> do
    (eChange, eRemove) <- todoItem item
    dTodo <- foldDyn ($) item eChange
    pure (dTodo, eRemove)

  let
    eRemoves =
      fmap (Nothing <$) .
      switchDyn .
      fmap (mergeMap . fmap snd) $
      dmes
    eListChange =
      leftmost [eInsert, eRemoves]
    dItems =
      fmap Map.elems .
      joinDynThroughMap .
      fmap (fmap fst) $
      dmes

  pure dItems
