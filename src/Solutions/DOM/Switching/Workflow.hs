{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
module Solutions.DOM.Switching.Workflow (
    workflowSolution
  ) where

import Reflex.Dom.Core

workflowSolution :: MonadWidget t m
                 => Event t ()
                 -> m (Dynamic t Int)
workflowSolution eChange = do
  let
    wReset = Workflow $ do
      eClick <- button "Wait..."
      pure (const 0 <$ eClick, wAdd <$ eChange)

    wAdd = Workflow $ do
      eClick <- button "Click me"
      pure ((+ 1) <$ eClick, wReset <$ eChange)

  deScore <- workflow wReset
  let
    eScore = switchDyn deScore

  foldDyn ($) 0 eScore
