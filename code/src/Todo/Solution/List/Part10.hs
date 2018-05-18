{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Todo.Solution.List.Part10 where

import Control.Lens

import qualified Data.Text as Text

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Todo.Common
import Todo.Solution.Item.Part5

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
  let
  eItem <- addItem
  eAdd  <- numberOccurrencesFrom (length items) eItem
  let
    eInsert = (\(k,v) -> k =: Just v) <$> eAdd
    m = Map.fromList . zip [0..] $ items
  (dmd, eRemoves) <- runEventWriterT . listHoldWithKey m eListChange $ \k item -> do
    (eChange, eRemove) <- todoItem item
    tellEvent $ k =: Nothing <$ eRemove
    foldDyn ($) item eChange

  let
    eListChange =
      leftmost [eRemoves, eInsert]
    dItems =
      fmap Map.elems .
      joinDynThroughMap $
      dmd

  pure dItems
