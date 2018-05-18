{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Switching.WidgetHold.Solution (
    widgetHoldSolution
  ) where

import Data.Bool (bool)

import Reflex.Dom.Core

widgetHoldSolution :: MonadWidget t m
                   => Event t Bool
                   -> m (Dynamic t Int)
widgetHoldSolution eClickable = do
  let
    wReset = do
      eClick <- button "Wait..."
      pure $ const 0 <$ eClick
    wAdd = do
      eClick <- button "Click me"
      pure $ (+ 1) <$ eClick

    ewMode = bool wReset wAdd <$> eClickable

  deScore <- widgetHold wReset ewMode
  let
    eScore = switchDyn deScore

  {-
  dweMode <- holdDyn wReset ewMode
  eeScore <- dyn dweMode
  eScore <- switchHold never eeScore
  -}

  foldDyn ($) 0 eScore
