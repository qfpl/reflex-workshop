{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Exercises.DOM.Switching.WidgetHold (
    widgetHoldExercise
  ) where

import Data.Bool

import Reflex.Dom.Core

widgetHoldExercise :: MonadWidget t m
                   => Event t Bool
                   -> m (Dynamic t Int)
widgetHoldExercise eClickable =
  pure (pure 0)
