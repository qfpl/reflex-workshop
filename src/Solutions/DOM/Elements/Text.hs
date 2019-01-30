{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Solutions.DOM.Elements.Text (
    textSolution
  ) where

import qualified Data.Text as Text

import Reflex.Dom.Core

textSolution :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textSolution dIn = do
  el "div" $
    text "Input"
  el "div" $
    dynText $ Text.pack . show <$> dIn
    -- display dIn
