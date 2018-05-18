{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
module Workshop.Collections.Lists.Displaying.Solution (
    displaySolution
  ) where

import Control.Monad (void)

import Data.Map (Map)
import qualified Data.Map as Map

import Reflex.Dom.Core

import Workshop.DOM.Inputs.TextInput.Common

displaySolution :: MonadWidget t m
                => [TodoItem]
                -> (Dynamic t TodoItem -> m (Event t (TodoItem -> TodoItem), Event t ()))
                -> m ()
displaySolution tis fSingle =
  let
    m = Map.fromList . zip [0..] $ tis
  in
    void . list (pure m) $
      void . fSingle

