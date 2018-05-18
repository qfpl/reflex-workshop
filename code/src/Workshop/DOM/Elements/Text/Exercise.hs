{-|
Copyright   : (c) 2018, Commonwealth Scientific and Industrial Research Organisation
License     : BSD3
Maintainer  : dave.laing.80@gmail.com
Stability   : experimental
Portability : non-portable
-}
{-# LANGUAGE OverloadedStrings #-}
module Workshop.DOM.Elements.Text.Exercise (
    textExercise
  ) where

import Reflex.Dom.Core

textExercise :: MonadWidget t m
             => Dynamic t Int
             -> m ()
textExercise dIn =
  pure ()
