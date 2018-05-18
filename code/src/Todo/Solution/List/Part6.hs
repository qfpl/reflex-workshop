{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Todo.Solution.List.Part6 where

import Control.Monad

import qualified Data.Map as Map

import Reflex.Dom.Core

import Todo.Common
import Todo.Solution.Item.Part5

todoListSolution :: MonadWidget t m
                 => [TodoItem]
                 -> m ()
todoListSolution items = do
  let
    m = Map.fromList . zip [0..] $ items
  void . listHoldWithKey m never $
    const todoItem
