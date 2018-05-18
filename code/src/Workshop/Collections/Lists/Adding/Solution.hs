{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecursiveDo #-}
module Workshop.Collections.Lists.Adding.Solution (
    addingSolution
  ) where

import Control.Monad (void)

import Control.Lens

import Data.Map (Map)
import qualified Data.Map as Map

import Data.Text (Text)
import qualified Data.Text as Text

import Reflex.Dom.Core

import Workshop.DOM.Inputs.TextInput.Common

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

addingSolution :: MonadWidget t m
               => [TodoItem]
               -> (Dynamic t TodoItem -> m (Event t (TodoItem -> TodoItem), Event t ()))
               -> m ()
addingSolution tis fSingle =
  let
    m = Map.fromList . zip [0..] $ tis
  in do
    eAdd <- addItem
    eInsert <- numberOccurrencesFrom (length tis) eAdd

    dMap <- foldDyn ($) m .
            mergeWith (.) $ [
              uncurry Map.insert <$> eInsert
            ]

    void . list dMap $
      void . fSingle
