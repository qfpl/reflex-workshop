{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Solutions.Todo.Collections.Displaying.List where

import Control.Monad

import qualified Data.Map as Map

import Reflex.Dom.Core

import Common.Todo
import Solutions.Todo.Collections.Displaying.Item

todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items
  void . listHoldWithKey m never $
    const todoItem
